class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true 
  has_many :events
  has_many :attendances, foreign_key: "attendee_id"
  has_many :parties, class_name:"Event",through: :attendances, source: :event

  has_secure_password
end
