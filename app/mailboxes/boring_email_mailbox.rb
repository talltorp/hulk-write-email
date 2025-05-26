class BoringEmailMailbox < ApplicationMailbox
  before_processing :boring_email_too_big_for_hulk?
  before_processing :puny_human_ask_to_be_hulk_friend?
  before_processing :puny_human_hulk_friend?

  def process
    boring_email = puny_human.boring_emails.create!(
      email: mail.from.first,
      subject: mail.subject,
      body: safe_body,
      message_id: inbound_email.message_id,
    )

    MakeBoringEmailFunnyJob.perform_later(boring_email)
  end

  private


  def puny_human_ask_to_be_hulk_friend?
    if not hulk_friend?
      return bounce_with BounceMailer.not_hulk_friend(mail.from)
    end
  end

  def puny_human_hulk_friend?
    if not puny_human.approved?
      return bounce_with GettingStartedMailer.ask_approval(puny_human.email, puny_human_approval_url(puny_human.to_signed_global_id))
    end
  end


  def boring_email_too_big_for_hulk?
    characters_hulk_can_fit_in_head = 8000

    if mail_body.length > characters_hulk_can_fit_in_head
      too_big_in_percent = (mail_body.length / characters_hulk_can_fit_in_head.to_f) * 100

      return bounce_with BounceMailer.too_big(mail.from, too_big_in_percent)
    end
  end

  def hulk_friend?
    not puny_human.nil?
  end

  def hulk_ok_with_write_email?
  end

  def puny_human
    @puny_human ||= PunyHuman.find_by(email: sender)
  end

  def sender
    mail.from.first
  end

  def safe_body
    Rails::Html::WhiteListSanitizer.new.sanitize(mail_body)
  end

  def mail_body
    return mail.text_part.decoded if mail.text_part
    return mail.body.decoded
  end
end
