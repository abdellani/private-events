require 'rails_helper'

RSpec.describe Attendance, type: :model do
  describe '#attendee' do
    it 'checks for many to many relation' do
      creator = User.create(name: 'creator', email: 'test@test.com', password: '123456')
      attendee = User.create(name: 'attendee', email: 'test1@test.com', password: '123456')
      event = Event.create(description: 'test description', date:'2019-08-26', user_id: 1)
      event.attendees << attendee
      attendance = Attendance.first

      expect(attendance.attendee).to eql(attendee)
      expect(attendance.event).to eql(event)
      expect(attendance.attendee).to_not eql(creator)
    end
  end
end
