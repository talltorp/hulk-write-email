# Preview all emails at http://localhost:3000/rails/mailers/bounce_mailer
class GettingStartedMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/bounce_mailer/missing_user
  def instructions
    puny_human = PunyHuman.last
    GettingStartedMailer.instructions(puny_human.email)
  end

  def ask_approval
    puny_human = PunyHuman.last
    GettingStartedMailer.ask_approval(puny_human.email, "http://localhost:3000/puny_human_approvals/strange-id")
  end

  def typing_done
    boring_email = BoringEmail.last
    GettingStartedMailer.with(boring_email:).typing_done
  end

end
