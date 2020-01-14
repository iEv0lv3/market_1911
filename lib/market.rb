class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.map do |vendor|
      vendor if vendor.inventory.include?(item)
    end
  end

  def sorted_item_list
    @vendors.map do |vendor|
      vendor.inventory.map do |item|
        item[0].name
      end
    end.flatten.uniq
  end

  def total_inventory
    @vendors.reduce(Hash.new(0)) do |item_hash, vendor|
      vendor.inventory.map do |item|
        item_hash[item[0]] += item[1]
      end
      item_hash
    end
  end

  def sell(item, amount)
    if availability_to_sell(item, amount) == true
      remove_from_stock(item, amount)
      true
    else
      false
    end
  end

  def availability_to_sell(item, amount)
    available = total_inventory
    available[item] >= amount
  end

  def remove_from_stock(item, amount)
    amount_remaining = amount
    @vendors.find_all do |vendor|
      next if vendor.inventory[item].zero?

      until vendor.inventory[item].zero? || amount_remaining.zero?
        vendor.inventory[item] -= 1
        amount_remaining -= 1
      end
    end
  end
end


# Add a method to your Market class called `sell` that takes an item and a quantity as arguments.
# There are two possible outcomes of the `sell` method:

# 1. If the Market does not have enough of the item in stock to satisfy the given quantity, this 
# method should return `false`.

# 2. If the Market's has enough of the item in stock to satisfy the given quantity,
# this method should return `true`. Additionally, this method should reduce the stock of the Vendors.
# It should look through the Vendors in the order they were added and sell the item from the first Vendor 
# with that item in stock. If that Vendor does not have enough stock to satisfy the given quantity,
# the Vendor's entire stock of that item will be depleted, and the remaining quantity will be sold 
# from the next vendor with that item in stock. It will follow this pattern until the entire quantity
# requested has been sold.

# For example, suppose vendor1 has 35 `peaches` and vendor3 has 65 `peaches`, and vendor1 was
# added to the market first. If the method `sell(<ItemXXX, @name = 'Peach'...>, 40)` is called,
# the method should return `true`, vendor1's new stock of `peaches` should be 0, and vendor3's new stock
# of `peaches` should be 60.

# Use TDD to update the `Market` class so that it responds to the following interaction pattern:

# pry(main)> market.sell(item1, 200)
# #=> false

# pry(main)> market.sell(item5, 1)
# #=> false

# pry(main)> market.sell(item4, 5)
# #=> true

# pry(main)> vendor2.check_stock(item4)
# #=> 45

# pry(main)> market.sell(item1, 40)
# #=> true

# pry(main)> vendor1.check_stock(item1)
# #=> 0

# pry(main)> vendor3.check_stock(item1)
# #=> 60
# ```
