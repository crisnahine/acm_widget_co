# frozen_string_literal: true

# Interface for applying offers to a basket
class OfferApplier
  # Calculate discount for given products
  # @param products [Array<Product>] products in the basket
  # @return [Float] discount amount
  def calculate_discount(products)
    raise NotImplementedError, "#{self.class} must implement #calculate_discount"
  end
end