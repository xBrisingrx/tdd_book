require 'rails_helper'

RSpec.describe Page, type: :model do
  let(:page) { build(:page) }

  it 'has a valid factory' do
    expect(page).to be_valid
  end
end
