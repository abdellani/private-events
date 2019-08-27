require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#name' do
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
      User.create(name:'test', email:'test@test.com', password:'123456')
      user = User.new
      user.name = 'test'
      user.valid?
      expect(user.errors[:name]).to include("has already been taken")

      user.name = 'test33242'
      user.valid?
      expect(user.errors[:name]).to_not include("has already been taken")
    end
  end

  describe '#email' do
    it 'validates for presence of email adress' do
      user = User.new
      user.name = 'test3334'
      user.email = '' 
      user.valid?
      expect(user.errors[:email]).to include("is invalid")

      user.email = 'test3334@gmail.com'
      user.valid?
      expect(user.errors[:email]).to_not include("is invalid")
    end

    it 'validates for format of email adress' do
      user = User.new
      user.name = 'test3334'
      user.email = 'test@test..com' 
      user.valid?
      expect(user.errors[:email]).to include("is invalid")

      user.email = 'test3334@gmail.com'
      user.valid?
      expect(user.errors[:email]).to_not include("is invalid")
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
end
