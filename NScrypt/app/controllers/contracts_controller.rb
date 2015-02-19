class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy]


  
  # GET /contracts
  # GET /contracts.json
  def index
    @contracts = Contract.where(owner: session[:user_id])
    # Also get where the user was a proposed party
    parties = Party.where("user_id = ? AND (state = 'Proposed' OR state = 'Signed')", session[:user_id])
    #parties = Party.where("user_id = ?", session[:user_id])
    parties.each{ |party| @contracts << party.code.contract }
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
  end

  # GET /contracts/new
  def new
    @contract = Contract.new
  end

  # GET /contracts/1/edit
  def edit
  end

  # POST /contracts
  # POST /contracts.json
  def create
    @contract = Contract.new(contract_params)
    @contract.owner = session[:user_id]

    respond_to do |format|
      if @contract.save
        format.html { redirect_to @contract, notice: 'Contract was successfully created.' }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update
    respond_to do |format|
      if @contract.update(contract_params)
        format.html { redirect_to @contract, notice: 'Contract was successfully updated.' }
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { render :edit }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract.destroy
    respond_to do |format|
      format.html { redirect_to contracts_url, notice: 'Contract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_contract
    @contract = Contract.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contract_params
    params.require(:contract).permit(:title, :description)
  end
end
