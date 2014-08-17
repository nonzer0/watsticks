class ContactsController < ApplicationController

  def create
    @contact = Contact.new(contact_params)
  end

  def new
    @contact = Contact.new
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :email, :position, :phone_number)
    end
end
