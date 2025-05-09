# frozen_string_literal: true

# Calculates delivery charges based on order subtotal and delivery rules
class DeliveryCalculator
  # Initialize with delivery rules
  # @param rules [Array<Hash>] array of rules with :threshold and :cost keys
  #   Each rule specifies a threshold and the delivery cost for orders at or above that threshold
  #   Rules should be sorted in ascending order by threshold
  def initialize(rules)
    @rules = rules.sort_by { |rule| rule[:threshold] }
  end

  # Calculate delivery charge based on subtotal
  # @param subtotal [Float] basket subtotal before delivery
  # @return [Float] delivery charge
  def calculate(subtotal)
    # Find the rule with the highest threshold that is still less than or equal to the subtotal
    applicable_rule = @rules.reverse.find { |rule| subtotal >= rule[:threshold] }
    applicable_rule ? applicable_rule[:cost] : 0
  end
end