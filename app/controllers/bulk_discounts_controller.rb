class BulkDiscountsController < ApplicationController
   before_action :find_merchant_and_discount, only: [:destroy, :show]
   before_action :find_merchant, only: [:index, :new, :create]

   def index
      @bulk_discounts = @merchant.bulk_discounts
   end

   def new
   end

   def show
   end

   def create
      bulk_discount = BulkDiscount.new(percentage: params[:percentage],
                        quantity: params[:quantity],
                        merchant: @merchant)
      if bulk_discount.save
         redirect_to merchant_bulk_discounts_path(@merchant)
      else
         flash.notice = "All fields must be completed. Quantity/Percentage can't be 0."
         redirect_to new_merchant_bulk_discount_path
      end
   end

   def destroy
      @bulk_discount.destroy
      redirect_to merchant_bulk_discounts_path
   end

   private
   def find_merchant
      @merchant = Merchant.find(params[:merchant_id])
   end

   def find_merchant_and_discount
      @merchant = Merchant.find(params[:merchant_id])
      @bulk_discount = BulkDiscount.find(params[:id])
   end
end