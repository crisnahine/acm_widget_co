# frozen_string_literal: true

require_relative 'product'
require_relative 'basket'
require_relative 'delivery_calculator'
require_relative 'buy_one_get_one_half_price_offer'

# Set up test environment
def setup_test_env
  catalog = {
    'R01' => Product.new('R01', 32.95),
    'G01' => Product.new('G01', 24.95),
    'B01' => Product.new('B01', 7.95)
  }

  delivery_rules = [
    { threshold: 90, cost: 0 },
    { threshold: 50, cost: 2.95 },
    { threshold: 0, cost: 4.95 }
  ]

  delivery_calculator = DeliveryCalculator.new(delivery_rules)
  offer = BuyOneGetOneHalfPriceOffer.new('R01')

  [catalog, delivery_calculator, offer]
end

# Test examples and verify results
def run_tests
  catalog, delivery_calculator, offer = setup_test_env

  examples = [
    { products: ['B01', 'G01'], expected_total: 37.85 },
    { products: ['R01', 'R01'], expected_total: 54.37 },
    { products: ['R01', 'G01'], expected_total: 60.85 },
    { products: ['B01', 'B01', 'R01', 'R01', 'R01'], expected_total: 98.27 }
  ]

  all_passed = true

  examples.each_with_index do |example, index|
    basket = Basket.new(catalog, delivery_calculator, [offer])

    example[:products].each do |product_code|
      basket.add(product_code)
    end

    actual_total = basket.total
    expected_total = example[:expected_total]
    passed = (actual_total == expected_total)

    puts "Example #{index + 1}:"
    puts "  Products: #{example[:products].join(', ')}"
    puts "  Expected total: $#{expected_total}"
    puts "  Actual total: $#{actual_total}"
    puts "  #{passed ? 'PASS' : 'FAIL'}"
    puts

    all_passed = all_passed && passed
  end

  puts all_passed ? "All tests PASSED!" : "Some tests FAILED!"
end

# Run the tests
if __FILE__ == $PROGRAM_NAME
  puts "Running Acme Widget Co basket tests:"
  puts "-" * 50
  run_tests
end