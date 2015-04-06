class DebugRunsController < ApplicationController
  before_action :set_debug_run, only: [:show, :edit, :update, :destroy]

  # GET /debug_runs
  # GET /debug_runs.json
  def index
    @debug_runs = DebugRun.all
  end

  # GET /debug_runs/1
  # GET /debug_runs/1.json
  def show
  end

  # GET /debug_runs/new
  def new
    @debug_run = DebugRun.new
  end

  # GET /debug_runs/1/edit
  def edit
  end

  # POST /debug_runs
  # POST /debug_runs.json
  def create
    @debug_run = DebugRun.new(debug_run_params)

    respond_to do |format|
      if @debug_run.save
        format.html { redirect_to @debug_run, notice: 'Debug run was successfully created.' }
        format.json { render :show, status: :created, location: @debug_run }
      else
        format.html { render :new }
        format.json { render json: @debug_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /debug_runs/1
  # PATCH/PUT /debug_runs/1.json
  def update
    respond_to do |format|
      if @debug_run.update(debug_run_params)
        format.html { redirect_to @debug_run, notice: 'Debug run was successfully updated.' }
        format.json { render :show, status: :ok, location: @debug_run }
      else
        format.html { render :edit }
        format.json { render json: @debug_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debug_runs/1
  # DELETE /debug_runs/1.json
  def destroy
    @debug_run.destroy
    respond_to do |format|
      format.html { redirect_to debug_runs_url, notice: 'Debug run was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_debug_run
      @debug_run = DebugRun.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def debug_run_params
      params.require(:debug_run).permit(:input, :output, :pre_state, :post_state, :code_id, :user_id, :has_error)
    end
end
