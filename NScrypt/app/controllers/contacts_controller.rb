class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.includes(:contact_user).where("(user_id = ? OR contact_user_id = ?) AND status = 'Connected'", session[:user_id], session[:user_id])
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    if session[:user_id] == params[:contact][:user_id].to_i
      raise "Cannot add yourself as a contact"
    end
    if Contact.exists?(["user_id = #{session[:user_id]} AND contact_user_id = ?", params[:contact][:user_id].to_i])
      logger.info("Bidirectional contact request--implied approval")
      @contact = Contact.where("user_id = #{session[:user_id]} AND contact_user_id = ?", params[:contact][:user_id].to_i).first
      @contact.status = 'Connected'
      @contact.save
      redirect_to @contact, notice: 'Connected.'
      return
    end
    if Contact.exists?(["user_id = ? AND contact_user_id = #{session[:user_id]}", params[:contact][:user_id].to_i])
      raise "Contact already exists"
    end

    @contact = Contact.new(contact_params)
    @contact.status = 'Pending'
    @contact.user_id = session[:user_id]
    @contact.contact_user_id = params[:contact][:user_id]

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'A contact request was sent.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm
    if @contact.contact_user_id == session[:user_id]
      @contact.status = 'Connected'
      @contact.save
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:status, :user_id)
    end
end
