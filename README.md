# Acme Widget Co - Shopping Basket

A Ruby implementation of a shopping basket system for Acme Widget Co that handles products, delivery charges, and special offers.

## Features

- Shopping basket with add and total methods
- Product catalog with codes and prices
- Tiered delivery charges based on order total
- Special offer implementation: "buy one red widget, get the second half price"
- Flexible architecture that can be extended with new products, delivery rules, and offers

## Architecture

The solution follows these design principles:

- **Separation of Concerns**: Each class has a clear, single responsibility
- **Dependency Injection**: Dependencies are passed to classes that need them
- **Strategy Pattern**: Offers are implemented as strategies that can be applied to the basket
- **Open/Closed Principle**: The system is designed to be extended without modifying existing code

### Components

- `Product`: Represents a product with code and price
- `Basket`: Manages shopping cart operations
- `DeliveryCalculator`: Calculates delivery charges based on subtotal
- `OfferApplier`: Interface for applying special offers
- `BuyOneGetOneHalfPriceOffer`: Implementation of the specific offer

## Usage

```ruby
# Create catalog
catalog = {
  'R01' => Product.new('R01', 32.95),
  'G01' => Product.new('G01', 24.95),
  'B01' => Product.new('B01', 7.95)
}

# Set up delivery rules
delivery_rules = [
  { threshold: 90, cost: 0 },
  { threshold: 50, cost: 2.95 },
  { threshold: 0, cost: 4.95 }
]
delivery_calculator = DeliveryCalculator.new(delivery_rules)

# Create offers
offers = [BuyOneGetOneHalfPriceOffer.new('R01')]

# Create basket
basket = Basket.new(catalog, delivery_calculator, offers)

# Add products
basket.add('R01')
basket.add('G01')

# Calculate total
total = basket.total
puts "Total: $#{total}"
```

## Running the Code

### Prerequisites

- Ruby 2.5+

### Examples

Run the example script:

```
ruby main.rb
```

Run the tests:

```
ruby simple_test.rb
```

## Assumptions

1. **Delivery Calculation**: Delivery charges are calculated based on the subtotal before any discounts are applied.

2. **Offer Application**: The "buy one get one half price" offer applies to pairs of the same product (R01). For each pair, one product gets a 50% discount.

3. **Multiple Offers**: The system is designed to support multiple offers, although currently only one is implemented.

4. **Product Uniqueness**: Product codes are unique within the catalog.

5. **Error Handling**: Adding a non-existent product code raises a KeyError.

## Extension Points

The system can be extended in the following ways:

1. **New Products**: Add new entries to the catalog
2. **New Delivery Rules**: Modify the rules array passed to DeliveryCalculator
3. **New Offers**: Create new classes implementing the OfferApplier interface# acm_widget_co
