feature 'Adding tags' do
  scenario 'I can click on a button to tag a post' do
    visit 'links/new'
      fill_in 'url', with: 'http://www.google.com'
      fill_in 'title', with: 'Google'
      fill_in 'tag', with: 'Search'

      click_button 'Submit'
      link = Link.first
      expect(link.tags.map(&:name)).to include('Search')
  end
  scenario 'Can add multiple tags to links' do
    visit 'links/new'
      fill_in 'url', with: 'http://www.bbc.com'
      fill_in 'title', with: 'BBC'
      fill_in 'tag', with: 'News education'

      click_button 'Submit'
      link = Link.first
      expect(link.tags.map(&:name)).to include('News', 'education')
  end
end
