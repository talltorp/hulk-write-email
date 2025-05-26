class CreateBoringEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :boring_emails do |t|
      t.string :email
      t.string :subject
      t.text :body
      t.text :summary
      t.text :funny_body
      t.string :message_id
      t.timestamps
    end
  end
end
