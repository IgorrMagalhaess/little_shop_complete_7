require "rails_helper"

RSpec.describe "bulk discounts index" do
   before :each do
      @merchant1 = Merchant.create!(name: "Hair Care")

      @discount1 = BulkDiscount.create!(quantity: 10, percentage: 10, merchant_id: @merchant1.id)
      @discount2 = BulkDiscount.create!(quantity: 20, percentage: 20, merchant_id: @merchant1.id)
      @discount3 = BulkDiscount.create!(quantity: 30, percentage: 30, merchant_id: @merchant1.id)

      visit merchant_bulk_discount_path(@merchant1, @discount1)
   end

   it 'see the bulk discount quantity threshold and percentage discount' do
      expect(page).to have_content("Bulk Discount ##{@discount1.id}")
      expect(page).to have_content("Min. Quantity: #{@discount1.quantity}")
      expect(page).to have_content("Percentage: 10%")
   end

   it 'has a link to edit the bulk discount' do
      expect(page).to have_content("Edit Bulk Discount ##{@discount1.id}")
   end
end