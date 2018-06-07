class CreateAndSendUserEmailService
  def initialize(params, authenticated_user)
    @params = params
    @authenticated_user = authenticated_user
    @users = []
  end

  def call
    @params.each do |k, email|
      if User.exists?(email: email)
        @users << "User with email: #{email} already exists"
      else
        User.new.tap do |u|
          u.email = email
          u.password = SecureRandom.hex
          u.member_id = @authenticated_user.member.id
          u.save!(validate: false)
          UserMailer.registration_confirmation(u).deliver
        end
      end
    end
    @users
  end
end
