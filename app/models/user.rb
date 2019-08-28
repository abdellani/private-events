# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_many :events
  has_many :attendances, foreign_key: 'attendee_id'
  has_many :attended_events, class_name: 'Event', through: :attendances, source: :event

  has_secure_password
end
