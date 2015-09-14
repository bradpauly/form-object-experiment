class RegistrationForm < ActiveForm::Form

  accepts_attributes_for :user, :name, :email, :password
  accepts_attributes_for :organization, :name

  within_save :associate_organization
  after_save :send_welcome_email

  def associate_organization
    organization.update_attribute(:user_id, user.id)
  end

  def send_welcome_email
    # UserMailer.welcome(user, organization).deliver
  end
end
