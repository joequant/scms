class ScValuesController < ApplicationController
  before_action :set_sc_value, only: [:show, :edit, :update, :destroy]

  # GET /sc_values
  # GET /sc_values.json
  def index
    @sc_values = ScValue.all
  end

  # GET /sc_values/1
  # GET /sc_values/1.json
  def show
  end

  # GET /sc_values/new
  def new
    @sc_value = ScValue.new
  end

  # GET /sc_values/1/edit
  def edit
  end

  # POST /sc_values
  # POST /sc_values.json
  def create
    @sc_value = ScValue.new(sc_value_params)

    respond_to do |format|
      if @sc_value.save
        format.html { redirect_to @sc_value, notice: 'Sc value was successfully created.' }
        format.json { render :show, status: :created, location: @sc_value }
      else
        format.html { render :new }
        format.json { render json: @sc_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sc_values/1
  # PATCH/PUT /sc_values/1.json
  def update
    respond_to do |format|
      if @sc_value.update(sc_value_params)
        format.html { redirect_to @sc_value, notice: 'Sc value was successfully updated.' }
        format.json { render :show, status: :ok, location: @sc_value }
      else
        format.html { render :edit }
        format.json { render json: @sc_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sc_values/1
  # DELETE /sc_values/1.json
  def destroy
    @sc_value.destroy
    respond_to do |format|
      format.html { redirect_to sc_values_url, notice: 'Sc value was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sc_value
      @sc_value = ScValue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sc_value_params
      params.require(:sc_value).permit(:contract_id, :key, :value)
    end
end
