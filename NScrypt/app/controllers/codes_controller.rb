class CodesController < ApplicationController
  before_action :set_code, only: [:show, :edit, :update, :destroy]


  def propose
    @code = Code.find(params[:code_id])

    @proposed = Code.where(:contract_id => @code.contract_id)
    @proposed.each do |c|
      if c.state == 'Proposed'
        c.state = 'Proposed_before'
        c.save
      end
    end
    @code.state = 'Proposed'
    @code.save
    redirect_to action: "show", id: :code_id
  end

  def sign
    @code = Code.find(params[:code_id])
    if @code.state == 'Proposed'
      @code.state = 'Signed'
      @code.save
    end
    redirect_to action: "show", id: :code_id
  end

  # GET /codes
  # GET /codes.json
  def index
    if params.has_key?(:contract_id)
      @codes = Code.where(contract_id:  params[:contract_id] )
    else
      @codes = Code.all
    end
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
end
