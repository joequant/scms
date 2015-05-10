class CodesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_admin!

  before_action :set_code, only: [:show, :edit, :update, :destroy]
  attr_reader :fm

  # GET /codes
  # GET /codes.json
  def index
    if params.has_key?(:contract_id)
      @codes = Code.where(contract_id: params[:contract_id])
    else
      @codes = Code.where("author = ? AND sign_state <> 'Signed' AND archived is not true", current_user.id)
      Party.where(user: current_user).each{ |p|
        @codes << p.code if p.code.proposed && p.code.author != current_user.id && !p.code.rejected && p.code.sign_state != 'Signed' && !p.code.archived
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
    @code.author = current_user.id
    @code.state = 'Unassigned'
    @code.sign_state = 'Unsigned'
    @code.assign_state = 'Unassigned'
    @code.proposed = false
    @code.posted = false
    if !params[:code][:template].blank?
      @code.code = Template.find(params[:code][:template]).code if params[:code].include?(:template)
    else
      @code.code = ""
    end
    @code.contract = Contract.find(params[:code][:contract]) if params[:code].include?(:contract) && !params[:code][:contract].empty?

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

  def archive
    @code = Code.find(params[:code_id])
    @code.archived = true
    @code.save
    redirect_to action: "index"
  end

  def propose
    logger.info("Proposing code to counter-parties")
    @code = Code.find(params[:code_id])
    @code.proposed = true
    @code.save
    logger.info("Notifying counter-parties")
    ContractNotifier.notify_proposal(@code).deliver_now
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
    open_slot.user = current_user
    open_slot.state = 'Signed'
    open_slot.save
    @code.contract.signed_code_id = @code.id
    @code.contract.save
    logger.info("Accepting posted offer")
    update_state
  end

  def duplicate
    if params.has_key?(:code_id)
      @code = Code.find(params[:code_id])
      old_code = Code.find(params[:code_id])
      version = Code.where(contract_id: old_code.contract_id).length

      new_code = Code.new
      new_code.author = current_user.id
      new_code.code = old_code.code
      new_code.contract_id = old_code.contract_id
      new_code.version = "#{version + 1}"
      new_code.assign_state = old_code.assign_state
      new_code.sign_state = 'Unsigned'
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
      @code = new_code
      set_code_state
      respond_to do |format|
        format.html { redirect_to new_code, notice: 'Code was successfully duplicated.' }
        format.json { head :no_content }
      end
    end
  end

  def debug
    @code = Code.find(params[:code_id])
    render :debugger
  end

  def debug_run
    @code = Code.find(params[:code_id])
    debug_code = params[:debug_code]
    has_error = false
    output = nil
    if @code.interpreter == 'ruby'
      begin
        logger.info("Launching debug run")
        require_relative '../../lib/nscrypt/scms.rb'
        $debug = {:notes => Array.new, :minutes => Array.new, :values => Hash.new, :parties => Hash.new, :log => Array.new, :rights => Array.new, :reputations => Array.new}
        $debug_backup = Marshal.load(Marshal.dump($debug))
        $scms = SCMS.new(self)
        $sc = SC.new(self, @code.contract.id, @code.contract.title, @code.contract.status, get_sc_values, get_sc_parties, get_sc_notes, get_sc_minutes)
        eval(@code.code)
        logger.info("Loaded debug run")
        begin
          output = eval(debug_code)
          logger.info("Finished debug run")
        rescue Exception => e
          has_error = true
          output = "Debug error: #{e.message}"
        end
      rescue Exception => e
        has_error = true
        output = "Loading error: #{e.message}"
      end
    end
    run = DebugRun.new(code: @code, input: debug_code, output: output, pre_state: $debug_backup.to_json, post_state: $debug.to_json, has_error: has_error, user: current_user)
    run.save
    redirect_to run
  end

  # LIBRARY CALLBACKS
  def add_sc_note(message)
    note = Note.new
    note.message = message
    note.contract = @sc_event.code.contract
    note.user = current_user
    $debug[:notes] << note
  end

  def get_sc_notes
    $debug[:notes].collect{ |n|
      username = User.find(n.user_id).name
      "#{username}: #{n.message}"
    }
  end

  def add_sc_minute(message)
    $debug[:minutes] << message
  end

  def get_sc_minutes
    $debug[:minutes]
  end

  def get_sc_values
    $debug[:values]
  end

  def set_sc_value(key, value)
    $debug[:values][key] = value
  end

  def set_sc_status(status)
    $debug[:log] << "Status changed to: #{status}"
    $debug[:status] = status
  end

  def get_sc_status
    $debug[:status]
  end

  def get_sc_source
    @code.code
  end

  def get_sc_parties
    parties = Party.includes(:user).where(code: @code)
    wallets_result = Wallet.where(user: parties.collect{ |p| p.user })
    wallets = Hash.new
    wallets_result.each{ |w|
      wallets[w.user] = Array.new if wallets[w.user].nil?
      wallets[w.user] << w
    }
    ps = Hash.new
    parties.each{ |p|
      w = Array.new
      wallets[p.user].each{ |r| w << ScmsWallet.new(r.currency, r.address) } if wallets.has_key?(p.user)
      ps[p.role] = ScmsUser.new(p.user.id, p.user.name, p.user.email, w)
    }
    ps
  end

  def grant_right(holder_user, right, grantor_user)
    $debug[:rights] << { :holder => holder_user, :grantor => grantor_user, :right => right, :subsists => true }
    $debug[:log] << "Right #{right} granted to #{holder_user.name} by #{grantor_user.name}"
  end

  def has_right?(holder_user, right, grantor_user)
    $debug[:rights].each{ |r|
      if r[:holder] == holder_user && r[:grantor] == grantor_user && r[:right] == right && r[:subsists] == true
        return true
      end
    }
    return false
  end

  def revoke_right(holder_user, right, grantor_user)
    $debug[:rights].each{ |r|
      if r[:holder] == holder_user && r[:grantor] == grantor_user && r[:right] == right && r[:subsists] == true
        r[:subsists] = false
      end
    }
    $debug[:log] << "Right #{right} revoked away from #{holder_user.name} by #{grantor_user.name}"
  end

  def add_reputation_note(user, item, params)
    message = "#{user.name}'s reputation is noted for #{item}"
    if !params.nil?
      message += " with parameters #{params}"
    end
    #message += " for category #{@code.category}, #{@code.subcategory}."
    $debug[:reputations] << message
  end

  def get_current_user
    wallets_result = Wallet.where(user: current_user)
    wallets = Array.new
    wallets_result.each{ |r| wallets << ScmsWallet.new(r.currency, r.address) }
    ScmsUser.new(current_user.id, current_user.username, current_user.email, wallets)
  end

  def get_current_user_id
    current_user.id
  end

  def send_sc_email(to, cc, subject, body)
    $debug[:log] << "Email sent--To: #{to}; CC: #{cc}; Subject: #{subject}; Body: #{body}"
  end

  def http_get(url)
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    response.body
  end

  def html_form(caption, event, params)
    event_url = url_to(event)
    html_code = "<form action=\"#{event_url}\"><fieldset>"
    html_code += "<legend>#{caption}</legend>"
    params.each{ |k, v| html_code += "#{k}<br><input type=\"#{v[:type]}\" name=\"sc_param_#{v[:name]}\"><br>" }
    html_code += "<input type=\"submit\" value=\"Submit\"></fieldset></form>"
    html_code
  end

  def url_to(event)
    events = ScEvent.where(callback: event, code: @code)
    event_id = nil
    if !events.empty?
      event_id = events.first.id
    else
      raise "Unable to find event '#{event}'"
    end
    "nscrypt.io/sc_events/#{event_id}/trigger"
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

    update_all_states
    redirect_to @code
  end

  def update_all_states
    set_assign_state
    set_sign_state
    set_code_state
  end

  def set_assign_state
    logger.info("Updating the Assignment State")
    parties = Party.where(code_id: @code.id)
    author = nil
    counterparties = Array.new
    assigned = Array.new
    unassigned = Array.new
    parties.each{ |p|
      if p.user.nil?
        unassigned << p
      else
        if @code.author == p.user.id
          author = p
        else
          counterparties << p
        end
        assigned << p
      end
    }

    code_assign_state = nil
    if assigned.length == parties.length && parties.length > 0
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
      unassigned.first.user = current_user
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
    logger.info("Updating the Signature State")
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
    if signed.length == parties.length && parties.length > 0
      code_sign_state = 'Signed'
    elsif !author.nil?
      if author.state == 'Signed'
        code_sign_state = 'Pre-signed'
      end
    elsif signed.length > 0 && signed.length == counterparties.length
      code_sign_state = 'Counter-signed'
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
    logger.info("Updating the Draft State")
    sign_state = @code.sign_state
    assign_state = @code.assign_state
    posted = @code.posted
    proposed = @code.proposed
    rejected = @code.rejected
    code_state = nil

    if rejected
      code_state = 'Rejected'
    elsif sign_state == 'Signed' && posted
      code_state = 'Accepted'
    elsif sign_state == 'Signed'
      code_state = 'Signed'
    elsif sign_state == 'Counter-signed'
      code_state = 'Counter-signed'
    elsif sign_state == 'Pre-signed'
      if proposed
        code_state = 'Offer'
      elsif posted && assign_state == 'Self-assigned'
        code_state = 'Open Offer'
      else
        code_state = 'Pre-signed'
      end
    elsif sign_state == 'Unsigned'
      if proposed
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
    run_directives(code)
    scrape_events(code)
    update_all_states
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
      p1 = $3.blank? ? $4 : $3
      case $1
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
    lines.grep(/\#NSCRYPT_DIRECTIVE\s+([a-zA-Z0-9_]+)\s+([\'\"]([a-zA-Z0-9_ ]+)[\'\"]|([a-zA-Z0-9_]+))\s+([\'\"]([a-zA-Z0-9_ :\-\+\.]+)[\'\"]|([a-zA-Z0-9_:\-\+\.]+))\s*$/){
      # Double-parameter directives
      p1 = $3.blank? ? $4 : $3
      p2 = $6.blank? ? $7 : $6
      case $1
      when 'set_interpreter'
        logger.info("Specified Interpreter: #{p1}, version #{p2}")
        code.interpreter = p1
        code.interpreter_version = p2
        code.save
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
    code.sc_event_id = nil
    code.save
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
