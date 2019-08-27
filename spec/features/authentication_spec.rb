# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentication', type: :feature do
  before :each do
    @user = User.create(name: 'creator', email: 'test@test.com', password: '123456')
  end
  scenario 'Authenticate with a valide username/password' do
    visit login_path
    fill_in 'session_name', with: 'creator'
    fill_in 'session_password', with: '123456'
    click_button 'Login'
    expect(page).to have_current_path(user_path(@user))
    expect(page).to have_content("User name : #{@user.name}")
    expect(page).to have_content("#{@user.name} created events:")
    expect(page).to have_content("#{@user.name} is attending next events:")
  end

  scenario 'Authenticate with valide username' do
    visit login_path
    fill_in 'session_name', with: 'test'
    fill_in 'session_password', with: '123456'
    click_button 'Login'
    expect(page).to have_content('Email or password is wrong!')
  end
  scenario 'Authenticate with valide password' do
    visit login_path
    fill_in 'session_name', with: 'creator'
    fill_in 'session_password', with: 'wrong password'
    click_button 'Login'
    expect(page).to have_content('Email or password is wrong!')
  end

  describe 'Logout' do
    scenario 'Logging user out after authentication ' do
      visit login_path
      fill_in 'session_name', with: 'creator'
      fill_in 'session_password', with: '123456'
      click_button 'Login'
      expect(page).to have_current_path(user_path(@user))
      expect(page).to have_content("User name : #{@user.name}")
      click_on 'Logout'
      expect(page).to have_current_path(login_path)
      expect(page).to have_content('You are not logged in !')
    end
  end
end
