require 'spec_helper.rb'

feature "the signup process" do

  context 'with valid input' do 
   it 'allows a user to signup' do 
    visit root_path
    click_link('Log In/Sign Up')
    expect{
      fill_in 'user[name]', :with => 'User Bob'
      fill_in 'user[email]', :with => 'user@example.com'
      fill_in 'user[password]',:with => 'password'
      fill_in 'user[password_confirmation]', :with => 'password'
      click_button 'Sign up'
      }.to change(User, :count).by(1)
    end
  end

  context 'with invalid input' do 
    it 'populates error messages' do 
      visit root_path
      click_link('Log In/Sign Up')
      expect{
        fill_in 'user[name]', :with => 'User Bob'
        fill_in 'user[email]', :with => 'user'
        fill_in 'user[password]',:with => 'password'
        fill_in 'user[password_confirmation]', :with => 'passwdffdsord'
        click_button 'Sign up'
        }.to change(User, :count).by(0)
      end
    end
  end