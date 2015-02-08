class PartiesController < ApplicationController
  before_action :set_party, only: [:show, :edit, :update, :destroy]


  def propose
    @party = Party.find(params[:party_id])
    @party.state = 'Proposed'
    @party.save
    redirect_to action: "show", id: params[:party_id]
  end

  def sign
    @party = Party.find(params[:party_id])
    @party.state = 'Signed'
    @party.save
    redirect_to action: "show", id: params[:party_id]
  end
  
  
  # GET /parties
  # GET /parties.json
  def index
    #@parties = Party.all

    if params.has_key?(:user_id)
      @parties = Party.where(user_id:  params[:user_id] )
    elsif params.has_key?(:code_id)
      @parties = Party.where(code_id:  params[:code_id] )
    else
      @parties = Party.all
    end
  end

  # GET /parties/1
  # GET /parties/1.json
  def show
  end

  # GET /parties/new
  def new
    @party = Party.new
  end

  # GET /parties/1/edit
  def edit
  end

  # POST /parties
  # POST /parties.json
  def create
    @party = Party.new(party_params)

    respond_to do |format|
      if @party.save
        format.html { redirect_to @party, notice: 'Party was successfully created.' }
        format.json { render :show, status: :created, location: @party }
      else
        format.html { render :new }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parties/1
  # PATCH/PUT /parties/1.json
  def update
    respond_to do |format|
      if @party.update(party_params)
        format.html { redirect_to @party, notice: 'Party was successfully updated.' }
        format.json { render :show, status: :ok, location: @party }
      else
        format.html { render :edit }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parties/1
  # DELETE /parties/1.json
  def destroy
    @party.destroy
    respond_to do |format|
      format.html { redirect_to parties_url, notice: 'Party was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_party
      @party = Party.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def party_params
      params.require(:party).permit(:user_id, :code_id, :role_id, :state)
    end
end
