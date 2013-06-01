class Ticket < ActiveRecord::Base
  attr_accessible :email, :issue, :name, :description, :status, :subject, :unique_reference

  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX }
  validates :subject, presence: true, length: { maximum: 70 }
  validates :description, presence: true, length: { minimum: 30 }

  extend FriendlyId
  friendly_id :unique_reference
end
