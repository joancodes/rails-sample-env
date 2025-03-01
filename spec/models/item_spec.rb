require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:company) }
    it { is_expected.to have_many(:vat_rates) }
    it { is_expected.to have_many(:deals) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
