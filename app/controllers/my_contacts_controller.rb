class MyContactsController < ApplicationController
helper_method :sort_column, :sort_direction
before_action :find_contact, only: [:show, :edit, :update, :destroy]

def index
  @contacts = Contact.where(name: authenticated_user.name).order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
end

def show
end

def new
  @contact = Contact.new
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
    params.require(:contact).permit(:name, :notes, :city, :state, :user_id, :display_name)
  end

  def find_contact
    @contact = Contact.find(params[:id])
  end

  def sort_column
    %w[title body created_at].include?(params[:column]) ? params[:column] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

end
