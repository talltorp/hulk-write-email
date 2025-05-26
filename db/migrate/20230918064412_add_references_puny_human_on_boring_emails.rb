class AddReferencesPunyHumanOnBoringEmails < ActiveRecord::Migration[7.0]
  def change
    add_reference :boring_emails, :puny_human, index: true
  end
end
