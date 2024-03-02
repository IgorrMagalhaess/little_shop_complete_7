require "rails_helper"

RSpec.describe "bulk discounts new" do
   before :each do
      @merchant1 = Merchant.create!(name: "Hair Care")

      @discount1 = BulkDiscount.create!(quantity: 10, percentage: 10, merchant_id: @merchant1.id)
      @discount2 = BulkDiscount.create!(quantity: 20, percentage: 20, merchant_id: @merchant1.id)
      @discount3 = BulkDiscount.create!(quantity: 30, percentage: 30, merchant_id: @merchant1.id)

      visit new_merchant_bulk_discount_path(@merchant1)
   end

   it 'has a form to fill in the attributes for the bulk discount' do
      expect(page).to have_field("percentage")
      expect(page).to have_field("quantity")
   end

   it 'can fill in form, click submit and redirect to the bulk discount index' do
      fill_in "percentage", with: 40
      fill_in "quantity", with: 40

      click_button "Submit"

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
      expect(page).to have_content("Min. Quantity: 40")
      expect(page).to have_content("Percentage: 40%")
   end

   it 'can fill in form, click submit and redirect to the new bulk discount if info is missing' do
      fill_in "percentage", with: 40
      fill_in "quantity", with: " "

      click_button "Submit"

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
      expect(page).to have_content("All fields must be completed. Quantity/Percentage can't be 0.")
   end

   it 'can fill in form, click submit and redirect to the new bulk discount if attributes are 0' do
      fill_in "percentage", with: 0
      fill_in "quantity", with: 0

      click_button "Submit"

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
      expect(page).to have_content("All fields must be completed. Quantity/Percentage can't be 0.")
   end
end