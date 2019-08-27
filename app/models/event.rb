class Event < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :attendances
  has_many :attendees, class_name:"User",through: :attendances
  validates :description, presence: true
  validates :date, presence: true
  scope :prev_events, -> { where("date <= ?",Time.now)}
  scope :upcoming_events, -> { where("date > ?",Time.now)}
end
