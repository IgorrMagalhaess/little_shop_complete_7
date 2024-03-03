require "rails_helper"

RSpec.describe "bulk discounts edit" do
   before :each do
      @merchant1 = Merchant.create!(name: "Hair Care")

      @discount1 = BulkDiscount.create!(quantity: 10, percentage: 10, merchant_id: @merchant1.id)

      visit edit_merchant_bulk_discount_path(@merchant1, @discount1)
   end

   it 'see the attributes are pre-populated in the form' do
      expect(find_field("bulk_discount[percentage]").value).to eq("#{@discount1.percentage}")
      expect(find_field("bulk_discount[quantity]").value).to eq("#{@discount1.quantity}")  
   end

   it "can fill in form, click submit, and redirect to that item's show page and see updated info and flash message" do
      fill_in "bulk_discount[percentage]", with: "20"
      fill_in "bulk_discount[quantity]", with: "20"

      click_button "Submit"

      expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))
      expect(page).to have_content("Min. Quantity: 20")
      expect(page).to have_content("Percentage: 20%")
      expect(page).to have_no_content("Percentage: 10%")
      expect(page).to have_content("Succesfully Updated Bulk Discount Info!")
   end

   it "shows a flash message if not all sections are filled in" do
      fill_in "bulk_discount[percentage]", with: " "
      fill_in "bulk_discount[quantity]", with: "0"

      click_button "Submit"

      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @discount1))
      expect(page).to have_content("All fields must be completed. Quantity/Percentage can't be 0.")
   end
end