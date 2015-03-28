class CodesController < ApplicationController
  before_action :set_code, only: [:show, :edit, :update, :destroy]
  attr_reader :fm

  # GET /codes
  # GET /codes.json
  def index
    if params.has_key?(:contract_id)
      @codes = Code.where(contract_id: params[:contract_id])
    else
      @codes = Code.where("author = ? AND state <> 'Signed'", session[:user_id])
      Party.where("user_id = ?", session[:user_id]).each{ |p|
        @codes << p.code if p.code.proposed == 't' && p.code.author != session[:user_id] && !p.code.rejected
      }
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
    @code.state = 'Unassigned'
    @code.sign_state = 'Unsigned'
    @code.assign_state = 'Unassigned'
    @code.proposed = false
    @code.posted = false
    process_code(@code)
    respond_to do |format|
      if @code.save
        format.html { redirect_to @code, notice: 'Draft was successfully created.' }
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

  def propose
    @code = Code.find(params[:code_id])
    @code.proposed = true
    @code.save
    logger.info("Proposing code to counter-parties")
    update_state
  end

  def retract
    @code = Code.find(params[:code_id])
    @code.proposed = false
    @code.save
    logger.info("Retracting proposal")
    update_state
  end

  def post
    @code = Code.find(params[:code_id])
    @code.posted = true
    @code.save
    logger.info("Posting open offer")
    update_state
  end

  def unpost
    @code = Code.find(params[:code_id])
    @code.posted = false
    @code.save
    logger.info("Unposting open offer")
    update_state
  end

  def reject
    @code = Code.find(params[:code_id])
    @code.rejected = true
    @code.save
    logger.info("Rejecting proposal")
    update_state
  end

  def accept
    @code = Code.find(params[:code_id])
    open_slot = nil
    @code.parties.each{ |s| open_slot = s if s.user.nil? }
    open_slot.user_id = session[:user_id]
    open_slot.state = 'Signed'
    open_slot.save
    logger.info("Accepting posted offer")
    update_state
  end

  def duplicate
    if params.has_key?(:code_id)
      old_code = Code.find(params[:code_id])
      version = Code.where(contract_id: old_code.contract_id).length

      new_code = Code.new
      new_code.author = session[:user_id]
      new_code.code = old_code.code
      new_code.contract_id = old_code.contract_id
      new_code.version = "#{version + 1}"
      process_code(new_code)
      new_code.save

      old_code.parties.each{ |p|
        new_party = nil
        new_code.parties.each{ |np|
          if np.role == p.role
            new_party = np
          end
        }
        if new_party.nil?
          new_party = Party.new
          new_party.code = new_code
          new_party.role = p.role
        end
        new_party.user = p.user
        new_party.save
      }

      respond_to do |format|
        format.html { redirect_to new_code, notice: 'Code was successfully duplicated.' }
        format.json { head :no_content }
      end
    end
  end

  def update_state
    if @code.nil?
      if params.include?(:party_id)
        @code = Party.find(params[:party_id]).code
      elsif params.include?(:code_id)
        @code = Code.find(params[:code_id])
      else
        raise "Something went wrong"
      end
    end

    set_assign_state
    set_sign_state
    set_code_state
    redirect_to @code
  end

  def set_assign_state
    parties = Party.where(code_id: @code.id)
    author = nil
    counterparties = Array.new
    assigned = Array.new
    unassigned = Array.new
    parties.each{ |p|
      if p.user.nil?
        unassigned << p
      else
        if @code.author == p.user_id
          author = p
        else
          counterparties << p
        end
        assigned << p
      end
    }

    code_assign_state = nil
    if assigned.length == parties.length
      code_assign_state = 'Assigned'
      logger.info("All roles are assigned")
    elsif !author.nil?
      code_assign_state = 'Self-assigned'
      logger.info("Self-Assigning author")
    elsif assigned.length == counterparties.length && unassigned.length == 1
      #code_assign_state = 'Counter-assigned'
      logger.info("Counter-assigning counterparty(ies)...")
      ### NOTE: Implying the author as the last remaining party--Must be a party to one's own contract
      logger.info("Assigning author to last remaining role")
      unassigned.first.user_id = @code.author
      unassigned.first.save
      code_assign_state = 'Assigned'
    else
      code_assign_state = 'Unassigned'
      logger.info("No assignments")
    end
    @code.assign_state = code_assign_state
    @code.save
  end

  def set_sign_state
    parties = Party.where(code_id: @code.id)
    author = nil
    counterparties = Array.new
    signed = Array.new
    parties.each{ |p|
      signed << p if p.state == 'Signed'
      if @code.author == p.user_id
        author = p
      else
        counterparties << p
      end
    }

    code_sign_state = 'Unsigned'
    if signed.length == parties.length
      code_sign_state = 'Signed'
    elsif signed.length == counterparties.length
      code_sign_state = 'Counter-signed'
    elsif !author.nil?
      if author.state == 'Signed'
        code_sign_state = 'Pre-signed'
      end
    end

    @code.sign_state = code_sign_state
    @code.save

    if code_sign_state == 'Signed'
      @code.contract.signed_code_id = @code.id
      if !@code.sc_event_id.nil?
        @code.contract.sc_event_id = @code.sc_event_id
      end
      @code.contract.save
      prev_values = ScValue.where(contract: @code.contract)
      prev_signed = false
      prev_values.each{ |v| prev_signed = true if v.key == 'Signature Date' }
      unless prev_signed
        value = ScValue.new
        value.contract = @code.contract
        value.key = 'Signature Date'
        value.value = Time.now
        value.save
      end
    end
  end

  def set_code_state
    sign_state = @code.sign_state
    assign_state = @code.assign_state
    posted = @code.posted
    proposed = @code.proposed
    rejected = @code.rejected
    code_state = nil

    if rejected
      code_state = 'Rejected'
    elsif sign_state == 'Signed' && posted == true
      code_state = 'Accepted'
    elsif sign_state == 'Signed'
      code_state = 'Signed'
    elsif sign_state == 'Counter-signed'
      code_state = 'Counter-signed'
    elsif sign_state == 'Pre-signed'
      if proposed == true
        code_state = 'Offer'
      elsif posted == true && assign_state == 'Self-assigned'
        code_state = 'Open Offer'
      elsif proposed == true
        code_state = 'Offer'
      else
        code_state = 'Pre-signed'
      end
    elsif sign_state == 'Unsigned'
      if proposed == true
        code_state = 'Proposed'
      else
        code_state = assign_state
      end
    end

    if !code_state.nil?
      @code.state = code_state
      @code.save
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
    if params.include?(:code)
      @code.code = Template.find(params[:code][:template]).code if params[:code].include?(:template)
      @code.contract = Contract.find(params[:code][:contract]) if params[:code].include?(:contract) && !params[:code][:contract].empty?
    end

    run_directives(code)
    scrape_events(code)
  end

  def run_directives(code)
    logger.info('Check for directives')
    old = Party.delete_all(code: code)
    content = code.code
    lines = content.split(/\r\n/)
    #lines.grep(/\#NSCRYPT_DIRECTIVE\s+([a-zA-Z0-9_]+)\s*$/){
      # Unary directives
    #}
    lines.grep(/\#NSCRYPT_DIRECTIVE\s+([a-zA-Z0-9_]+)\s+([\'\"]([a-zA-Z0-9_ ]+)[\'\"]|([a-zA-Z0-9_]+))\s*$/){
      # Single-parameter directives
      p1 = $3.nil? ? $4 : $3
      case $1
      when 'set_version'
        logger.info("Specified NScrypture version: #{p1}")
      when 'set_party_role'
        logger.info("Setting party role: #{p1}")
        party = Party.new
        party.role = p1
        party.code = code
        party.save
      else
        raise "WARNING: invalid directive action: #{$1}"
      end
    }
    lines.grep(/\#NSCRYPT_DIRECTIVE\s+([a-zA-Z0-9_]+)\s+([\'\"]([a-zA-Z0-9_ ]+)[\'\"]|([a-zA-Z0-9_]+))\s+([\'\"]([a-zA-Z0-9_ :\-\+]+)[\'\"]|([a-zA-Z0-9_ :\-\+]+))\s*$/){
      # Double-parameter directives
      p1 = $3.empty? ? $4 : $3
      p2 = $6.empty? ? $7 : $6
      case $1
      when 'preset_field'
        logger.info("Setting field preset: #{p1}: #{p2}")
        unless ScValue.where(contract: code.contract, key: p1).length > 0
          value = ScValue.new
          value.contract = code.contract
          value.key = p1
          value.value = p2
          value.save
        end
      else
        raise "WARNING: invalid directive action: #{$1}"
      end
    }
  end
  
  def scrape_events(code)
    logger.info('Scrape events.')
    old = ScEvent.delete_all(code: code)
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
