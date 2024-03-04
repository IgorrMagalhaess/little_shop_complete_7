class BulkDiscount < ApplicationRecord
  validates :percentage, numericality: { greater_than: 0 }
  validates :quantity, numericality: { greater_than: 0 }
  validates :merchant_id, presence: true

  belongs_to :merchant
end
