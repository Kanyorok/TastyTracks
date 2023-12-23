module LoginHelper
  def login_user(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'testing'
    click_button 'Log in'
    sleep(1)
  end
end
