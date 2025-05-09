# frozen_string_literal: true

require_relative 'product'
require_relative 'basket'
require_relative 'delivery_calculator'
require_relative 'buy_one_get_one_half_price_offer'

# Set up the product catalog
def create_catalog
  {
    'R01' => Product.new('R01', 32.95),
    'G01' => Product.new('G01', 24.95),
    'B01' => Product.new('B01', 7.95)
  }
end

# Set up delivery rules
def create_delivery_rules
  [
    { threshold: 90, cost: 0 },     # Orders $90+ have free delivery
    { threshold: 50, cost: 2.95 },  # Orders $50+ but under $90 cost $2.95
    { threshold: 0, cost: 4.95 }    # Orders under $50 cost $4.95
  ]
end

# Create offers
def create_offers
  [
    BuyOneGetOneHalfPriceOffer.new('R01') # Buy one red widget, get the second half price
  ]
end

# Create a basket with our catalog, delivery rules, and offers
def create_basket
  catalog = create_catalog
  delivery_calculator = DeliveryCalculator.new(create_delivery_rules)
  offers = create_offers

  Basket.new(catalog, delivery_calculator, offers)
end

# Test with the example baskets
def test_examples
  examples = [
    { products: ['B01', 'G01'], expected_total: 37.85 },
    { products: ['R01', 'R01'], expected_total: 54.37 },
    { products: ['R01', 'G01'], expected_total: 60.85 },
    { products: ['B01', 'B01', 'R01', 'R01', 'R01'], expected_total: 98.27 }
  ]

  examples.each_with_index do |example, index|
    basket = create_basket

    example[:products].each do |product_code|
      basket.add(product_code)
    end

    actual_total = basket.total
    expected_total = example[:expected_total]

    puts "Example #{index + 1}:"
    puts "  Products: #{example[:products].join(', ')}"
    puts "  Expected total: $#{expected_total}"
    puts "  Actual total: $#{actual_total}"
    puts "  #{actual_total == expected_total ? 'PASS' : 'FAIL'}"
    puts
  end
end

# Run the examples
if __FILE__ == $PROGRAM_NAME
  puts "Testing Acme Widget Co shopping basket implementation:"
  puts "-" * 50
  test_examples
end