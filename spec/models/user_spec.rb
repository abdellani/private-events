# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    User.create(name: 'test', email: 'test@test.com', password: '123456')
  end

  describe '#name' do
    before :each do
      User.create(name: 'test', email: 'test@test.com', password: '123456')
    end
    it 'doesnt take user without the name' do
      user = User.new
      user.name = nil
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")

      user.name = 'test'
      user.valid?
      expect(user.errors[:name]).to_not include("can't be blank")
    end

    it 'validates for name uniquness' do
      user = User.new
      user.name = 'test'
      user.valid?
      expect(user.errors[:name]).to include('has already been taken')

      user.name = 'test33242'
      user.valid?
      expect(user.errors[:name]).to_not include('has already been taken')
    end
  end

  describe '#email' do
    it 'validates for presence of email adress' do
      user = User.new
      user.name = 'test3334'
      user.email = ''
      user.valid?
      expect(user.errors[:email]).to include('is invalid')

      user.email = 'test3334@gmail.com'
      user.valid?
      expect(user.errors[:email]).to_not include('is invalid')
    end

    it 'validates for format of email adress' do
      user = User.new
      user.name = 'test3334'
      user.email = 'test@test..com'
      user.valid?
      expect(user.errors[:email]).to include('is invalid')

      user.email = 'test3334@gmail.com'
      user.valid?
      expect(user.errors[:email]).to_not include('is invalid')
    end
  end

  describe '#password' do
    it 'doesnt take user without the password' do
      user = User.new
      user.password = ''
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")

      user.password = '123456'
      user.valid?
      expect(user.errors[:password]).to_not include("can't be blank")
    end
  end

  describe '#attended_events' do
    it 'should be able to list attendees' do
      creator = User.create(name: 'creator', email: 'creator@email.com', password: '123456')
      attendee = User.create(name: 'attendee', email: 'attendee@email.com', password: '123456')
      event = Event.create(description: 'event description', user_id: creator.id)
      event.attendees << attendee
      expect(User.last.attended_events.first).to eql(event)
    end
  end
  describe '#events' do
    it 'should be able to list attendees' do
      creator = User.create(name: 'creator', email: 'creator@email.com', password: '123456')
      attendee = User.create(name: 'attendee', email: 'attendee@email.com', password: '123456')
      event = Event.create(description: 'event description', user_id: creator.id)
      event.attendees << attendee
      expect(User.first.events.first).to eql(event)
    end
  end
end
