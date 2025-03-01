# require 'rails_helper'

RSpec.describe VatRate, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:rate) }
    it { is_expected.to belong_to(:item) }
    it { should validate_numericality_of(:rate).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:rate).is_less_than_or_equal_to(30) }
  end
end
