class MakeBoringEmailFunnyJob < AiJobBase
  queue_as :default

  def perform(boring_email)
    @boring_email = boring_email

    make_email_funny

    GettingStartedMailer.with(boring_email: boring_email)
      .typing_done
      .deliver_later
  end

  private

  def boring_email
    @boring_email
  end

  def reference_to_funny_event
    first_reference = File.read(File.join(Rails.root, '..', 'first_reference.txt')).strip
    other_references = File.readlines(File.join(Rails.root, '..',  'other_references.txt')).map(&:strip)
    
    return first_reference if first_email_for_puny_human?

    ((rand(3) == 2) ? first_reference : other_references.sample)
  end

  def first_email_for_puny_human?
    BoringEmail.where(puny_human: boring_email.puny_human).count == 1
  end

  def make_email_funny
    template = File.read(File.join(Rails.root, '..', 'hulk_prompt_template.txt'))
    
    prompt = template % {
      funny_event: reference_to_funny_event,
      subject: boring_email.subject,
      body: boring_email.body
    }

    funny_body = ask_ai_with prompt

    boring_email.update!(funny_body: funny_body)
  end
end
