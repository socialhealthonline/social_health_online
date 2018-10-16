class MyContactsController < ApplicationController
before_action :find_contact, only: [:show, :edit, :update, :destroy]

def index
  @contacts = Contact.where(user_id: authenticated_user.id).page(params[:page]).per(10)
end

def show
end

def new
  contact = Contact.where(contact_id: params[:contact_id], user_id: authenticated_user.id)

  if contact.present?
    redirect_to my_contacts_path
  else
    contact = Contact.new
    user = User.find(params[:contact_id])
    contact.user_id = authenticated_user.id
    contact.contact_id = user.id
    contact.save
    redirect_to my_contacts_path, success: 'The contact was successfully created!'
  end

end

def create
  @contact = Contact.new(contact_params)
  @contact.name = authenticated_user.name
  if @contact.save
    redirect_to my_contacts_path, success: 'The contact was successfully created!'
  else
    flash.now[:error] = 'Please correct the errors to continue.'
    render :new
  end
end

def edit
  if @contact.name != authenticated_user.name
    redirect_to my_contacts_path
  else
    render :edit
  end
end

def update
  if @contact.update(contact_params)
    redirect_to my_contacts_path, success: 'The contact was successfully updated!'
  else
    flash.now[:error] = 'Please correct the errors to continue.'
    render :edit
  end
end

def destroy
  @contact.destroy
  redirect_to my_contacts_path, success: 'The contact was successfully deleted!'
end

private

  def contact_params
    params.require(:contact).permit(:name, :user_id, :display_name)
  end

  def find_contact
    @contact = Contact.find(params[:id])
  end
end
