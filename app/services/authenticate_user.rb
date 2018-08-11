class AuthenticateUser

  attr_reader :flash

  def initialize(user, params)
    @user = user
    @params = params
    @authenticated = false
    @flash = nil
  end

  def call
    if authenticated_manager? || authenticated_user?
      set_authenticated_user_attributes
    else
      @authenticated = false
      if @user.nil? # no user
        @flash = 'The email or password you entered was not recognized. Please try again!'
      elsif @user.member&.suspended || @user.disabled?
        @flash = 'Your account has been disabled!'
      elsif @user.enabled? # bad password
        @flash = 'The email or password you entered was not recognized. Please try again!'
      end
    end
    self
  end

  def success?
    @authenticated
  end

  def authenticated_manager?
    @user && @user.authenticate(@params[:password]) && @user.manager? && !@user.disabled?
  end

  def authenticated_user?
    @user && @user.authenticate(@params[:password]) && !@user.member&.suspended && !@user.disabled?
  end

  def set_authenticated_user_attributes
    @authenticated = true
    @flash = "Welcome, #{@user.name}!"
  end
end
