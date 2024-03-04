require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many(:invoices).through(:merchant)}
  end

  describe "validations" do
    it { should validate_numericality_of :percentage }
    it { should validate_numericality_of :quantity }
    it { should validate_presence_of :merchant_id }
  end
end
