class CreatePunyHumans < ActiveRecord::Migration[7.0]
  def change
    create_table :puny_humans do |t|
      t.string :email
      t.datetime :approved_at
      t.timestamps
    end
  end
end
