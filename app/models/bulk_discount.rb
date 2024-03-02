class BulkDiscount < ApplicationRecord
  validates :percentage, numericality: true
  validates :quantity, numericality: true
  validates :merchant_id, presence: true

  belongs_to :merchant
end
