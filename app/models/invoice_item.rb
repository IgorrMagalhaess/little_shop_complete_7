class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def converted_price
    unit_price.to_f / 100
  end

  def applied_discounts
    # item.merchant.bulk_discounts.where("quantity <=?", quantity)
    BulkDiscount.select("bulk_discounts.*")
    .where("bulk_discounts.quantity_thresh <= #{self.quantity}")
    .order("bulk_discounts.percentage DESC")
    .first
  end
end
