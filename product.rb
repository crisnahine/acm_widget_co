# frozen_string_literal: true

# Represents a product in the Acme Widget Co catalog
class Product
  attr_reader :code, :price

  # Initialize a product with a code and price
  # @param code [String] unique product code
  # @param price [Float] product price
  def initialize(code, price)
    @code = code
    @price = price
  end
end