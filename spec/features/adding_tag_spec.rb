feature 'Adding tags' do
  scenario 'I can click on a button to tag a post' do
    visit 'links/new'
      fill_in 'url', with: 'http://www.google.com'
      fill_in 'title', with: 'Google'
      fill_in 'tag', with: 'Search engine'

      click_button 'Submit'
      link = Link.first
      expect(link.tags.map(&:name)).to include('Search engine')
  end
end
