class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")/100
  end

  def total_revenue_with_discount
    total_discount = invoice_items.joins(item: {merchant: :bulk_discounts})
                                  .where("bulk_discounts.quantity <= invoice_items.quantity")
                                  .where("bulk_discounts.merchant_id = merchants.id")
                                  .maximum("bulk_discounts.percentage * invoice_items.unit_price * invoice_items.quantity / 100 / 100") #divide to 100 to get percentage and to get cents to dolar

    total_revenue - (total_discount || 0)
  end
end
