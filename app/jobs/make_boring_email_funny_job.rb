class MakeBoringEmailFunnyJob < AiJobBase
  queue_as :default

  def perform(boring_email)
    @boring_email = boring_email
    puts "=> WRITE WHAT HULK SAY"

    write_what_hulk_say

    GettingStartedMailer.with(boring_email: boring_email)
      .typing_done
      .deliver_later(wait_until: 5.minutes.from_now)
  end

  private

  def boring_email
    @boring_email
  end

  def reference_to_funny_event
    return Hulk.first_reference if first_email_for_puny_human?

    ((rand(3) == 2) ? Hulk.first_reference : Hulk.other_references.sample)
  end

  def first_email_for_puny_human?
    BoringEmail.where(puny_human: boring_email.puny_human).count == 1
  end

  def write_what_hulk_say
    prompt = Hulk.hulk_prompt_template % {
      funny_event: reference_to_funny_event,
      subject: boring_email.subject,
      body: boring_email.body
    }

    funny_body = ask_ai_with prompt

    boring_email.update!(funny_body: funny_body)
  end
end
