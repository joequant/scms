class ScEventRunsController < ApplicationController
  before_action :set_sc_event_run, only: [:show, :edit, :update, :destroy]

  # GET /sc_event_runs
  # GET /sc_event_runs.json
  def index
    @sc_event_runs = ScEventRun.all
  end

  # GET /sc_event_runs/1
  # GET /sc_event_runs/1.json
  def show
  end

  # GET /sc_event_runs/new
  def new
    @sc_event_run = ScEventRun.new
  end

  # GET /sc_event_runs/1/edit
  def edit
  end

  # POST /sc_event_runs
  # POST /sc_event_runs.json
  def create
    @sc_event_run = ScEventRun.new(sc_event_run_params)

    respond_to do |format|
      if @sc_event_run.save
        format.html { redirect_to @sc_event_run, notice: 'Sc event run was successfully created.' }
        format.json { render :show, status: :created, location: @sc_event_run }
      else
        format.html { render :new }
        format.json { render json: @sc_event_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sc_event_runs/1
  # PATCH/PUT /sc_event_runs/1.json
  def update
    respond_to do |format|
      if @sc_event_run.update(sc_event_run_params)
        format.html { redirect_to @sc_event_run, notice: 'Sc event run was successfully updated.' }
        format.json { render :show, status: :ok, location: @sc_event_run }
      else
        format.html { render :edit }
        format.json { render json: @sc_event_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sc_event_runs/1
  # DELETE /sc_event_runs/1.json
  def destroy
    @sc_event_run.destroy
    respond_to do |format|
      format.html { redirect_to sc_event_runs_url, notice: 'Sc event run was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sc_event_run
      @sc_event_run = ScEventRun.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sc_event_run_params
      params.require(:sc_event_run).permit(:sc_event_id, :run_at, :result)
    end
end
