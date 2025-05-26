class GettingStartedMailer < ApplicationMailer

  default from: email_address_with_name("help@hulkwriteemail.com", "Hulk write email")

  def ask_approval(puny_human_email, puny_human_approval_url)
    @puny_human_approval_url = puny_human_approval_url

    mail to: puny_human_email, subject: "You want to be email friend of Hulk?"
  end

  def instructions(puny_human_email)
    @greeting = "HELLOOOO!!!!"

    mail to: puny_human_email, subject: "How to be good email friend of Hulk!!"
  end

  def typing_done
    @boring_email = params[:boring_email]

    @greeting = "GRRRR"

    mail(to: @boring_email.email,
         subject: "Re: #{@boring_email.subject}",
         references: "<#{@boring_email.message_id}>"
        )
  end
end
