# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events Managment', type: :feature do
  before :each do
    @user = User.create(name: 'creator', email: 'test@test.com', password: '123456')
    @event = Event.create(description: 'This is test event', date: '2019-08-26', user_id: @user.id)
    User.create(name: 'test45', email: 'test2@test2.com', password: '123456')
    Event.create(description: 'This is test this event', date: '2019-08-26', user_id: 2)
    visit login_path
    fill_in 'session_name', with: 'creator'
    fill_in 'session_password', with: '123456'
    click_button 'Login'
    expect(page).to have_current_path(user_path(@user))
    expect(page).to have_content("User name : #{@user.name}")
  end

  scenario 'Creates valid new event' do
    click_on 'Create new event'
    expect(page).to have_current_path(new_event_path)
    fill_in 'event_description', with: 'test'
    fill_in 'event_date', with: '2019-08-26'
    click_button 'Create new event'
    expect(page).to have_current_path(event_path(Event.last))
    expect(page).to have_content("Creator: #{@user.name}")
    expect(page).to_not have_current_path(events_path)
  end

  scenario 'Creates invalid event without date' do
    click_on 'Create new event'
    expect(page).to have_current_path(new_event_path)
    fill_in 'event_description', with: 'test'
    fill_in 'event_date', with: ''
    click_button 'Create new event'
    expect(page).to have_current_path(events_path)
    expect(page).to have_content('Description')
  end

  scenario 'Creates invalid event without description' do
    click_on 'Create new event'
    expect(page).to have_current_path(new_event_path)
    fill_in 'event_description', with: ''
    fill_in 'event_date', with: '2019-08-26'
    click_button 'Create new event'
    expect(page).to have_current_path(events_path)
    expect(page).to have_content('Description')
  end

  scenario 'User views all events' do
    click_on 'Show all events'
    expect(page).to have_current_path(events_path)
    expect(page).to have_content('This is test event')
    expect(page).to have_content('2019-08-26')
    expect(page).to_not have_current_path(login_path)
  end

  scenario 'User views single event' do
    visit event_path(@event)
    expect(page).to have_current_path(event_path(@event.id))
    expect(page).to have_content('This is test event')
    expect(page).to have_content('2019-08-26')
  end

  scenario 'User views single event' do
    visit events_path
    expect(page).to have_current_path(events_path)
    first(:link, 'Attend this event').click
    expect(page).to have_current_path(user_path(@event.id))
    expect(page).to have_content('This is test event')
    expect(page).to_not have_content('This is test this event')
  end
end
