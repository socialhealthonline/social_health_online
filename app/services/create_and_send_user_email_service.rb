class CreateAndSendUserEmailService
  def initialize(params, authenticated_user)
    @params = params
    @authenticated_user = authenticated_user
    @exists_users = []
  end

  def call
    @params.each do |k, email|
      if User.exists?(email: email)
        @exists_users << "User with email: #{email} already exists"
      else
        password = SecureRandom.hex
        User.new.tap do |u|
          u.email = email
          u.password = password
          u.member_id = @authenticated_user.member.id
          u.user_status = :pending
          u.save!(validate: false)
          UserMailer.registration_confirmation(u, password).deliver
          HiddenField.create(user_id: u.id)
        end
      end
    end
    @exists_users
  end
end
