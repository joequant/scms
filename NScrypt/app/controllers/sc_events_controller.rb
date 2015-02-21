class ScEventsController < ApplicationController
  before_action :set_sc_event, only: [:show, :edit, :update, :destroy]

  # GET /sc_events
  # GET /sc_events.json
  def index
    if params.has_key?(:code_id)
      @sc_events = ScEvent.where(code_id: params[:code_id])
    else
      @sc_events = ScEvent.all
    end
    
  end

  def trigger
    if params.has_key?(:sc_event_id)
      @sc_event = ScEvent.find(params[:sc_event_id])
      logger.info("loading code for sc_event: "+params[:sc_event_id])
      sc_event = ScEvent.find(params[:sc_event_id])

      require './lib/nscrypt/scms.rb'
      $scms = SCMS.new(session[:user_id])
      $sc = SC.new($scms, self)

      eval(@sc_event.code.code)
      logger.info("Calling callback")
      ret = eval(sc_event.callback)
      run = ScEventRun.new(:sc_event => sc_event, :run_at => Time.now, :result => ret)
      run.save

      redirect_to run
    end
  end
  # GET /sc_events/1
  # GET /sc_events/1.json
  def show
  end

  # GET /sc_events/new
  def new
    @sc_event = ScEvent.new
  end

  # GET /sc_events/1/edit
  def edit
  end

  # POST /sc_events
  # POST /sc_events.json
  def create
    @sc_event = ScEvent.new(sc_event_params)

    respond_to do |format|
      if @sc_event.save
        format.html { redirect_to @sc_event, notice: 'Sc event was successfully created.' }
        format.json { render :show, status: :created, location: @sc_event }
      else
        format.html { render :new }
        format.json { render json: @sc_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sc_events/1
  # PATCH/PUT /sc_events/1.json
  def update
    respond_to do |format|
      if @sc_event.update(sc_event_params)
        format.html { redirect_to @sc_event, notice: 'Sc event was successfully updated.' }
        format.json { render :show, status: :ok, location: @sc_event }
      else
        format.html { render :edit }
        format.json { render json: @sc_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sc_events/1
  # DELETE /sc_events/1.json
  def destroy
    @sc_event.destroy
    respond_to do |format|
      format.html { redirect_to sc_events_url, notice: 'Sc event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # LIBRARY CALLBACKS
  def get_sc_id
    @sc_event.code.contract.id
  end

  def add_sc_note(message)
    note = Note.new
    note.note = message
    note.contract = @sc_event.code.contract
    note.save
  end

  def get_sc_notes
    notes = Note.where(contract: @sc_event.code.contract)
    notes.collect{ |n| n.note }
  end

  def get_sc_values
    ScValue.where(contract: @sc_event.code.contract)
  end

  #def get_sc_value(key)
  #  values = ScValue.where(contract: @sc_event.code.contract, key: key)
  #  raise "Can't find value for #{key}" if values.empty?
  #  values.first[:value]
  #end

  def set_sc_value(key, value)
    values = ScValue.where(contract: @sc_event.code.contract, key: key)
    value_obj = nil
    if values.empty?
      value_obj = ScValue.new
    else
      value_obj = values.first
    end
    value_obj.contract = @sc_event.code.contract
    value_obj.key = key
    value_obj.value = value
    value_obj.save
  end

  def set_sc_status(status)
    @sc_event.code.contract.status = status
    @sc_event.code.contract.save
  end

  def get_sc_source
    @sc_event.code.code
  end

  def get_sc_parties
    parties = Party.includes(:user).includes(:role).where(code: @sc_event.code)
    wallets_result = Wallet.where(user: parties.collect{ |p| p.user })
    wallets = Hash.new
    wallets_result.each{ |w|
      wallets[w.user] = Array.new if wallets[w.user].nil?
      wallets[w.user] << w
    }
    { :parties => parties, :wallets => wallets}
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sc_event
    @sc_event = ScEvent.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sc_event_params
    params.require(:sc_event).permit( :callback, :code_id)
  end

end
