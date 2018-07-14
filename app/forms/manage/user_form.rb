class Manage::UserForm
  attr_reader :error

  def initialize(user, current_user)
    @user = user
    @current_user = current_user
    @error = ""
  end

  def submit(params)
    @user.attributes = params
    @user.save(validate: false)
  end

  def validate_fields(params)
    if @user.pending?
      if check_user_status(params)
        @error = "You can't switch the User status."
      elsif check_user_email(params)
        @error = "You can't switch the User email until the account is activated."
      end
    elsif check_if_manager_switch_own_status(params)
      @error = "You can't switch your own status."
    end
    @error
  end

  private

  def check_user_status(params)
    params[:user_status] && !params[:user_status]&.downcase&.eql?('pending')
  end

  def check_user_email(params)
    !@user.email.eql?(params[:email]&.downcase)
  end

  def check_if_manager_switch_own_status(params)
    @user.id == @current_user.id && !@current_user.user_status.eql?(params[:user_status]&.downcase)
  end
end
