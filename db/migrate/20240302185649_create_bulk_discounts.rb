class CreateBulkDiscounts < ActiveRecord::Migration[7.1]
  def change
    create_table :bulk_discounts do |t|
      t.integer :quantity
      t.integer :percentage
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
