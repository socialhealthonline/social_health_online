class CreateManagerAndSendEmailService
  def initialize(member, user_name, user_email)
    @member = member
    @user_name = user_name
    @user_email = user_email
    @password = SecureRandom.hex
  end

  def call
    User.new.tap do |u|
      u.name = @user_name
      u.email = @user_email
      u.password = @password
      u.member_id = @member.id
      u.manager = true
      u.save!(validate: false)
      UserMailer.registration_confirmation(u, @password).deliver
      HiddenField.create(user_id: u.id)
    end
  end
end
