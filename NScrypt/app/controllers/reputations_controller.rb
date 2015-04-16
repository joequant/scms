class ReputationsController < ApplicationController
  before_action :set_reputation, only: [:show, :edit, :update, :destroy]

  # GET /reputations
  # GET /reputations.json
  def index
    @reputations = Reputation.where(user: current_user, status: 'Active')
  end

  # GET /reputations/1
  # GET /reputations/1.json
  def show
  end

  # GET /reputations/new
  def new
    @reputation = Reputation.new
  end

  # GET /reputations/1/edit
  def edit
  end

  # POST /reputations
  # POST /reputations.json
  def create
    @reputation = Reputation.new(reputation_params)

    respond_to do |format|
      if @reputation.save
        format.html { redirect_to @reputation, notice: 'Reputation was successfully created.' }
        format.json { render :show, status: :created, location: @reputation }
      else
        format.html { render :new }
        format.json { render json: @reputation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reputations/1
  # PATCH/PUT /reputations/1.json
  def update
    respond_to do |format|
      if @reputation.update(reputation_params)
        format.html { redirect_to @reputation, notice: 'Reputation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reputation }
      else
        format.html { render :edit }
        format.json { render json: @reputation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reputations/1
  # DELETE /reputations/1.json
  def destroy
    @reputation.destroy
    respond_to do |format|
      format.html { redirect_to reputations_url, notice: 'Reputation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reputation
      @reputation = Reputation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reputation_params
      params.require(:reputation).permit(:user_id, :contract_id, :category, :subcategory, :item, :params, :status)
    end
end
