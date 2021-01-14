class ContactsController < ApplicationController
    include Pagy::Backend

    before_action :verify_authenticated
    before_action :verify_contact_owner_valid, only: [:edit, :update, :destroy]

    layout "default"

    # GET /contacts
    def index
        contacts = Contact.where("user_id = :user_id AND (first_name LIKE :keyword OR last_name LIKE :keyword OR email LIKE :keyword)", {
            :user_id => current_user.id,
            :keyword => "%#{params[:keyword]}%"
        })
        @pagy, @contacts = pagy_array(contacts, page: params[:page], items: 12)
    end

    # GET /contacts/create
    def new
        @contact = Contact.new
    end

    # POST /contacts/create
    def create
        @contact = Contact.new(
            user_id: current_user.id,
            first_name: params[:contact][:first_name],
            last_name: params[:contact][:last_name],
            email: params[:contact][:email],
            company: params[:contact][:company],
            department: params[:contact][:department],
            phone1: params[:contact][:phone1],
            phone2: params[:contact][:phone2],
            notes: params[:contact][:notes],
            custom_field1: params[:contact][:custom_field1],
            custom_field2: params[:contact][:custom_field2],
        )
        if @contact.save
            redirect_to contacts_path, flash: { success: "New contact has been added." }
        else
            render :new
        end
    end

    # GET /contacts/:id/edit
    def edit
    end

    # PUT /contacts/:id/edit
    def update
        if @contact.update(contact_params)
            redirect_to contacts_path, flash: { success: "Information successfully updated." }
        else
            render :edit
        end
    end

    # DELETE /contacts/:id
    def destroy
        @contact.destroy

        redirect_to contacts_path
    end

    def contact_params
        params.require(:contact).permit(
            :first_name,
            :last_name,
            :email,
            :company,
            :department,
            :phone1,
            :phone2,
            :notes,
            :custom_field1,
            :custom_field2
        )
    end

    private

    def verify_authenticated
        redirect_to root_path unless current_user
    end

    def verify_contact_owner_valid
        @contact = Contact.find_by(id: params[:id])
        redirect_to root_path if @contact.user_id != current_user.id
    end
end
