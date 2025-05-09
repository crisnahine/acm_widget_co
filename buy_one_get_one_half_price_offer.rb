# frozen_string_literal: true

require_relative 'offer_applier'

# Implements "buy one, get one half price" offer for specific product
class BuyOneGetOneHalfPriceOffer < OfferApplier
  # Initialize with product code that offer applies to
  # @param product_code [String] the product code eligible for the offer
  def initialize(product_code)
    @product_code = product_code
  end

  # Calculate discount based on "buy one, get one half price" rule
  # For every pair of matching products, apply 50% discount to one of them
  # @param products [Array<Product>] products in the basket
  # @return [Float] total discount amount
  def calculate_discount(products)
    # Filter products that match the offer's product code
    eligible_products = products.select { |product| product.code == @product_code }

    # Calculate how many products get the half-price discount (integer division by 2)
    discounted_count = eligible_products.count / 2

    # Calculate total discount (half price for each qualifying product)
    discount = 0
    if discounted_count > 0
      discount = discounted_count * (eligible_products.first.price / 2.0)
    end

    discount
  end
end