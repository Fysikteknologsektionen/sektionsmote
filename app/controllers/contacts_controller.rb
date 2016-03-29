class ContactsController < ApplicationController
  load_permissions_and_authorize_resource

  def index
    # @contacts initially set by Cancancan
    @contacts = @contacts.order(:name)
  end

  def show
    @contact = Contact.find(params[:id])
    @contact.message = ContactMessage.new
  end

  def mail
    @contact = Contact.find(params[:id])
    @contact.message ||= ContactMessage.new(message_params)

    if @contact.send_email
      redirect_to contact_path(@contact), notice: t('contact.message_sent')
    else
      flash[:alert] = t('contact.something_wrong')
      render :show, status: 422
    end
  end

  private

  def message_params
    params.require(:contact_message).permit(:name, :email, :message)
  end
end
