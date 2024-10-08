require 'rails_helper'

RSpec.describe PageSearch do
  subject { PageSearch }

  describe '.search' do
    it 'nil params return no pages' do
      expect(subject.search(nil)).to eq([])
    end

    it 'empty params return no pages' do
      expect(subject.search({})).to eq([])
    end

    it 'an empty term is not send to .by_term' do
      allow(Page).to receive(:by_term)
      PageSearch.search({ term: '' })
      expect(Page).to_not have_received(:by_term)
    end

    it 'a nil term is not send to .by_term' do
      allow(Page).to receive(:by_term)
      PageSearch.search({ term: nil })
      expect(Page).to_not have_received(:by_term)
    end

    it 'a valid term is send to .by_term' do
      allow(Page).to receive(:by_term)
      PageSearch.search({ term: 'foo' })
      expect(Page).to have_received(:by_term).with('foo')
    end

    it 'valid year and month are sent to .by_year_month' do
      allow(Page).to receive(:by_year_month)
      PageSearch.search({ year: 2024, month: 8 })
      expect(Page).to have_received(:by_year_month).with(2024, 8)
    end
  end
end
