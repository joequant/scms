class CreateWalletsController < ApplicationController
  before_action :set_create_wallet, only: [:show, :edit, :update, :destroy]

  # GET /create_wallets
  # GET /create_wallets.json
  def index
    @create_wallets = CreateWallet.all
  end

  # GET /create_wallets/1
  # GET /create_wallets/1.json
  def show
  end

  # GET /create_wallets/new
  def new
    @create_wallet = CreateWallet.new
  end

  # GET /create_wallets/1/edit
  def edit
  end

  # POST /create_wallets
  # POST /create_wallets.json
  def create
    @create_wallet = CreateWallet.new(create_wallet_params)

    respond_to do |format|
      if @create_wallet.save
        format.html { redirect_to @create_wallet, notice: 'Create wallet was successfully created.' }
        format.json { render :show, status: :created, location: @create_wallet }
      else
        format.html { render :new }
        format.json { render json: @create_wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /create_wallets/1
  # PATCH/PUT /create_wallets/1.json
  def update
    respond_to do |format|
      if @create_wallet.update(create_wallet_params)
        format.html { redirect_to @create_wallet, notice: 'Create wallet was successfully updated.' }
        format.json { render :show, status: :ok, location: @create_wallet }
      else
        format.html { render :edit }
        format.json { render json: @create_wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /create_wallets/1
  # DELETE /create_wallets/1.json
  def destroy
    @create_wallet.destroy
    respond_to do |format|
      format.html { redirect_to create_wallets_url, notice: 'Create wallet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_create_wallet
      @create_wallet = CreateWallet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def create_wallet_params
      params.require(:create_wallet).permit(:currency, :address, :user_id)
    end
end
