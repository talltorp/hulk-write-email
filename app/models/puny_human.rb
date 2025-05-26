class PunyHuman < ApplicationRecord
  self.table_name = "puny_humans"

  has_many :boring_emails

  validates_presence_of :email
  validates_uniqueness_of :email

  def approved?
    approved_at.present?
  end

  def approve!
    update!(approved_at: Time.current)
  end
end
