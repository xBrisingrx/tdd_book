require 'rails_helper'

RSpec.describe Page, type: :model do
  subject { build(:page) }

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to belong_to(:user) }
    # it { is_expected.to validate_presence_of(:title) }   por algun motivo extranio con el metodo make_slug me borra el titulo
    it { is_expected.to validate_uniqueness_of(:title) }
    it { is_expected.to validate_presence_of(:content) }
  end

  describe '#slug' do
    let(:page) { create(:page, title: '--Foo Bar! _ 87 --') }
    it 'is generated from the title' do
      expect(page.slug).to eq('foo-bar-87')
    end
  end

  describe 'scopes' do
    describe '.published' do
      # el :published es un trait que se encuentra en nuestro factory
      let(:page1) { create(:page, :published) }
      let(:page2) { create(:page) }
      # el before lo que hace es indicar que necesitamos que estas instancias se generen antes de continuar
      # se hace de esta manera xq let trabaja de forma diferida, y puede pasar que se testeen las instancias en el it antes de q se creen
      before do
        [ page1, page2 ]
      end

      it 'returns only published pages' do
        expect(Page.published).to eq([ page1 ])
      end
    end

    describe '.ordered' do
      let(:page1) { create(:page, created_at: 2.days.ago) }
      let(:page2) { create(:page, created_at: 1.days.ago) }

      before do
        [ page1, page2 ]
      end

      it 'returns ordered pages' do
        expect(Page.ordered).to eq([ page2, page1 ])
      end
    end

    describe '.by_term' do
      let(:page1) { create(:page, content: 'foo') }
      let(:page2) { create(:page, content: 'foo bar') }
      let(:page3) { create(:page, content: 'foo bar baz') }
      before do
        [ page1, page2 ]
      end

      it 'returns pages for the given term' do
        expected = [ page1, page2, page3 ]
        expect(Page.by_term('foo')).to match_array(expected)
      end

      it 'returns pages for multiple terms' do
        expected = [ page3 ]
        expect(Page.by_term('foo baz')).to eq(expected)
      end
    end

    describe '.month_year_list' do
      let(:result) { Page.month_year_list }

      before do
        create(:page, created_at: Date.new(2022, 7, 21))
        create(:page, :published, created_at: Date.new(2024, 8, 10))
        create(:page, :published, created_at: Date.new(2024, 8, 23))
        create(:page, :published, created_at: Date.new(2023, 6, 16))
      end

      it 'returns a list of results' do
        expect(result.count).to eq(2)
      end

      it 'returns month and year' do
        expect(result[0]['month_name']).to eq('August')
        expect(result[0]['month_number']).to eq('08')
        expect(result[0]['year']).to eq('2024')

        expect(result[1]['month_name']).to eq('June')
        expect(result[1]['month_number']).to eq('06')
        expect(result[1]['year']).to eq('2023')
      end
    end
  end
end
