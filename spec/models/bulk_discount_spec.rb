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

  describe "#completed_invoices" do
    it 'returns false if there are any invoices in progress' do
      @merchant1 = Merchant.create!(name: "Hair Care")
      @merchant2 = Merchant.create!(name: "Skin Care")

      @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 1)
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 35, unit_price: 10, status: 0)
      @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)

      @discount1 = BulkDiscount.create!(quantity: 10, percentage: 10, merchant_id: @merchant1.id)
      @discount2 = BulkDiscount.create!(quantity: 20, percentage: 20, merchant_id: @merchant1.id)
      @discount3 = BulkDiscount.create!(quantity: 30, percentage: 30, merchant_id: @merchant2.id)

      expect(@discount1.completed_invoices?).to eq(false)
    end

    it 'returns true if there are no invoices in progress' do
      @merchant1 = Merchant.create!(name: "Hair Care")
      @merchant2 = Merchant.create!(name: "Skin Care")

      @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 1)
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 35, unit_price: 10, status: 0)
      @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)

      @discount1 = BulkDiscount.create!(quantity: 10, percentage: 10, merchant_id: @merchant1.id)
      @discount2 = BulkDiscount.create!(quantity: 20, percentage: 20, merchant_id: @merchant1.id)
      @discount3 = BulkDiscount.create!(quantity: 30, percentage: 30, merchant_id: @merchant2.id)

      expect(@discount3.completed_invoices?).to eq(true)
    end
  end
end
