require 'rails_helper'

RSpec.describe "SunnyPath", type: :system do
  include ActiveJob::TestHelper

  before do
    driven_by(:rack_test)
    clear_emails
  end

  scenario "Puny human not friend of Hulk send email to Hulk" do
    perform_enqueued_jobs do
      expect { incoming_email_to_hulk("test@example.com") }.not_to change(BoringEmail, :count)
    end
  end

  scenario "Hulk sends email when puny human signs up with valid email" do
    visit "/"

    expect {
      fill_in :puny_human_email, with: "test@example.com"
      click_on "Smash to send!"
    }.to change { PunyHuman.count }.by 1

    expect(page).to have_text "send instructions to inbox"

    # Send an email now and see ignore it

    perform_enqueued_jobs
    open_email('test@example.com')
    expect(current_email).not_to have_content("how easy it works")

    current_email.click_link "You smash link to say you want to be a good email friend"

    expect(page).to have_text "Hulk have new email friend!"

    perform_enqueued_jobs

    open_email('test@example.com')

    expect(current_email).to have_content("hulk@hulkwriteemail.com")
    expect(current_email).to have_content("HELLO EMAIL FRIEND!")
    
    # Send an email now and see that we get a response
    stub_open_ai
    
    perform_enqueued_jobs do
      expect { incoming_email_to_hulk("test@example.com") }.to change(BoringEmail, :count).by(1)
    end

    open_email('test@example.com')
    expect(current_email.html_part.to_s).to match(/Test text AI/i)

  end

  private

  let(:to_email) { "hulk@hulkwriteemail.com" }
  let(:body) do
    {
      text_part: ">>> Forwarded message\n\nThis is a long and very boring email with important stuff in it",
      html_part: %Q(
        >>> Forwarded message<br><br>
        This is a long and very boring email<b> with</b> important stuff in it
      )
    }
  end

  def incoming_email_to_hulk(from = "test@example.com")
    receive_inbound_email_from_mail(
      from: from,
      to: to_email,
      subject: 'Fwd: Reminder',
      parts: [
        { body: body[:text_part], content_type: 'text/plain' },
        { body: body[:html_part], content_type: 'text/html' }
      ]
    )
  end

  def stub_open_ai
    stub_request(:post, "https://api.openai.com/v1/chat/completions")
      .to_return(status: 200, body: open_ai_response, headers: {})
  end

  def open_ai_response
    {
      choices: [
        message: {
          content: "Test text AI"
        }
      ]
    }.to_json
  end
end
