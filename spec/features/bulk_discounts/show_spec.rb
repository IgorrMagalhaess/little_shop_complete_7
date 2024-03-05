require "rails_helper"

RSpec.describe "bulk discounts show" do
   before :each do
      @merchant1 = Merchant.create!(name: "Hair Care")
      @merchant2 = Merchant.create!(name: "Skin Care")

      @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 1)
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant2.id)
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 35, unit_price: 10, status: 0)
      @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)

      @discount1 = BulkDiscount.create!(quantity: 10, percentage: 10, merchant_id: @merchant1.id)
      @discount2 = BulkDiscount.create!(quantity: 20, percentage: 20, merchant_id: @merchant1.id)
      @discount3 = BulkDiscount.create!(quantity: 30, percentage: 30, merchant_id: @merchant2.id)

      visit merchant_bulk_discount_path(@merchant1, @discount1)
   end

   it 'see the bulk discount quantity threshold and percentage discount' do
      expect(page).to have_content("Bulk Discount ##{@discount1.id}")
      expect(page).to have_content("Min. Quantity: #{@discount1.quantity}")
      expect(page).to have_content("Percentage: 10%")
   end

   it 'has a link to edit the bulk discount' do
      expect(page).to have_content("Edit Bulk Discount ##{@discount1.id}")

      click_link "Edit Bulk Discount ##{@discount1.id}"

      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @discount1))
   end
end