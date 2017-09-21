feature 'Creating links' do
  scenario 'I can use a form to create a link' do
    visit '/links/new'
      fill_in 'url', with: 'http://www.makersacademy.com'
      fill_in 'title', with: 'Makers Academy'
      click_button 'Submit'
      expect(page).to have_content('Makers Academy')
      expect(page).to have_content('http://www.makersacademy.com')
  end
end
