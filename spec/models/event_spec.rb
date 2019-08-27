require 'rails_helper'
require 'date'

RSpec.describe Event, type: :model do
  describe '#author' do
    it 'should have creator' do
      user = User.create(name: 'test', email: 'test@test.com', password: '123456')
      event = user.events.build(description: 'test description')
      event.valid?
      expect(event.errors[:creator]).to_not include("must exist")

      event = Event.new(description: 'test description')
      event.valid?
      expect(event.errors[:creator]).to include("must exist")
    end
  end

  describe '#prev_events' do
    it 'gets all previous events' do
      User.create(name: 'test', email: 'test@test.com', password: '123456')
      user = User.find(1)
      event = user.events.build(description: 'test description', date:'2019-08-26')
      event.save

      expect(user.events.prev_events.first.date).to eql(DateTime.parse("2019-08-26"))

      event2 = user.events.build(description: 'test description', date:'2019-09-26')
      event2.save
      expect(user.events.prev_events.first.date).to_not eql(DateTime.parse("2019-09-26"))
    end
  end

  describe '#upcoming_events' do
    it 'gets all events in the future' do
      User.create(name: 'test', email: 'test@test.com', password: '123456')
      user = User.find(1)
      event = user.events.build(description: 'test description', date:'2019-09-26')
      event.save

      expect(user.events.upcoming_events.first.date).to eql(DateTime.parse("2019-09-26"))

      event2 = user.events.build(description: 'test description', date:'2019-08-26')
      event2.save
      expect(user.events.upcoming_events.first.date).to_not eql(DateTime.parse("2019-08-26"))
    end
  end
end
