# frozen_string_literal: true

# Manages shopping cart operations for Acme Widget Co
class Basket
  # Initialize the basket with catalog, delivery calculator, and offers
  # @param catalog [Hash<String, Product>] product catalog keyed by product code
  # @param delivery_calculator [DeliveryCalculator] calculates delivery charges
  # @param offers [Array<OfferApplier>] offer strategies to apply
  def initialize(catalog, delivery_calculator, offers = [])
    @catalog = catalog
    @delivery_calculator = delivery_calculator
    @offers = offers
    @products = []
  end

  # Add a product to the basket by product code
  # @param product_code [String] code of the product to add
  # @raise [KeyError] if product code doesn't exist in catalog
  def add(product_code)
    product = @catalog[product_code]
    raise KeyError, "Product code '#{product_code}' not found in catalog" unless product
    @products << product
  end

  # Calculate the total cost of the basket including delivery and offers
  # @return [Float] total cost rounded to 2 decimal places
  def total
    subtotal = calculate_subtotal
    discount = apply_offers
    delivery = @delivery_calculator.calculate(subtotal)

    total = subtotal - discount + delivery
    total.round(2)
  end

  private

  # Calculate subtotal of all products in basket
  # @return [Float] sum of all product prices
  def calculate_subtotal
    @products.sum(&:price)
  end

  # Apply all offers to calculate total discount
  # @return [Float] total discount amount
  def apply_offers
    @offers.sum { |offer| offer.calculate_discount(@products) }
  end
end