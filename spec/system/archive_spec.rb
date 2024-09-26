require 'rails_helper'

RSpec.describe 'Archives' do
  describe 'Results page' do
    before do
      create(:page, :published, created_at: '2024-08-23')
    end

    it 'renders archives search results' do
      visit root_path
      click_on 'August 2024'
      articles = find_all('article')
      expect(articles.count).to eq(1)

      within articles.first do
        expect(page).to have_css('h2', text: Page.first.title)
      end
    end
  end
end
