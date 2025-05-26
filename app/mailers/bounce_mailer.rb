class BounceMailer < ApplicationMailer

  default from: email_address_with_name("grrrrrr@hulkwriteemail.com", "Angry Hulk")

  def missing_user(not_found_email)
    @greeting = "That's not right.."

    mail to: not_found_email
  end

  def too_big(email, too_big_in_percent)
    @greeting = "Body too big"
    @too_big_in_percent = too_big_in_percent

    mail to: email
  end

  def not_hulk_friend(email)
    mail to: email
  end

end
