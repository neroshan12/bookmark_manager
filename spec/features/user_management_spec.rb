require 'web_helper'

feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, nero@hotmail.com')
    expect(User.first.email).to eq('nero@hotmail.com')
  end
  scenario 'requires a matching confirmation password' do
    expect{sign_up(password_confirmation: 'wrong')}.not_to change(User, :count)
  end
  scenario 'with a password that does not match' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users') # current_path is a helper provided by Capybara
    expect(page).to have_content 'Please refer to the following errors below:'
  end
  scenario 'I cannot sign up without an email address' do
    expect { sign_up(email: nil) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content('Email must not be blank')
  end
  scenario 'I cannot sign up with an invalid email address' do
    expect { sign_up(email: "invalid@email") }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content('Email has an invalid format')
  end
  scenario "I cannot sign up with an existing email" do
    sign_up
    expect { sign_up }.to_not change(User, :count)
    expect(page).to have_content('Email is already taken')
  end
end
