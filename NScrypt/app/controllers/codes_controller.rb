class CodesController < ApplicationController
  before_action :set_code, only: [:show, :edit, :update, :destroy]



  # GET /codes
  # GET /codes.json
  def index
    if params.has_key?(:contract_id)
      @codes = Code.where(contract_id: params[:contract_id])
    else
      @codes = Code.where("author = ? AND state <> 'Signed'", session[:user_id])
      Party.where("user_id = ? AND state in ('Proposed', 'Signed')", session[:user_id]).each{ |p| @codes << p.code if !@codes.include?(p.code) && p.code.state != 'Signed' }
    end
    @codes = @codes.sort{ |a, b| b <=> a }
  end

  # GET /codes/1
  # GET /codes/1.json
  def show
  end

  # GET /codes/new
  def new
    @code = Code.new
  end

  # GET /codes/1/edit
  def edit
  end

  # POST /codes
  # POST /codes.json
  def create
    @code = Code.new(code_params)
    @code.author = session[:user_id]
    @code.state = 'Not Signed'
    process_code(@code)
    respond_to do |format|
      if @code.save
        format.html { redirect_to @code, notice: 'Code was successfully created.' }
        format.json { render :show, status: :created, location: @code }
      else
        format.html { render :new }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /codes/1
  # PATCH/PUT /codes/1.json
  def update
    respond_to do |format|
      if @code.update(code_params)
        process_code(@code)
        format.html { redirect_to @code, notice: 'Code was successfully updated.' }
        format.json { render :show, status: :ok, location: @code }
      else
        format.html { render :edit }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /codes/1
  # DELETE /codes/1.json
  def destroy
    @code.destroy
    respond_to do |format|
      format.html { redirect_to codes_url, notice: 'Code was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_code
    @code = Code.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def code_params
    params.require(:code).permit(:version, :code, :contract_id)
  end

  def process_code(code)
    @code.code = Template.find(params[:code][:template]).code if params[:code].include?(:template)
    @code.contract = Contract.find(params[:code][:contract]) if params[:code].include?(:contract) && !params[:code][:contract].empty?

    run_directives(code)
    scrape_events(code)
  end

  def run_directives(code)
    logger.info('Check for directives')
    old = Party.delete_all(code: @code)
    content = code.code
    lines = content.split(/\r\n/)
    lines.grep(/\#NSCRYPT_DIRECTIVE\s+([a-zA-Z0-9_]+)\s+([a-zA-Z0-9_]+)/){
      if $1 == 'set_version'
        logger.info("Specified NScrypture version: #{$2}")
      elsif $1 == 'set_party_role'
        logger.info("Setting party role: #{$2}")
        party = Party.new
        party.role = $2
        party.code = code
        party.save
      else
        logger.info "WARNING: invalid directive action: #{$1}"
      end
    }
  end
  
  def scrape_events(code)
    logger.info('Scrape events.')
    old = ScEvent.delete_all(code: @code)
    content = code.code
    lines = content.split(/\r\n/)
    lines.grep(/^\s*def\s+(sc_event_[a-zA-Z0-9_]+)/){
      sc_event = ScEvent.new
      sc_event.callback = $1
      sc_event.code = code
      sc_event.save
      logger.info($1)
      if $1 == 'sc_event_portal'
        code.sc_event_id = sc_event.id
        code.save
        if code.id == code.contract.signed_code_id
          code.contract.sc_event_id = sc_event.id
          code.contract.save
        end
      end
    }
  end    

end
