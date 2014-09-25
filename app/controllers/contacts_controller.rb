class ContactsController < ApplicationController

  def create
    @contact = Contact.new(contact_params)
    respond_to do |format|
      if @contact.save
        format.html { redirect_to job_path(@contact.job_id), notice: "Contact created" }
        format.js   { }
        format.json { render json: @contact }
      else
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
        render @job
      end
    end
  end

  def new
    @contact = Contact.new
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :email, :position, :phone_number, :job_id)
    end
end
