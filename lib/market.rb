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
end


# Add a method to your `Market` class called `sorted_item_list` that returns a list of names of all items the Vendors have in stock, sorted alphabetically. This list should not include any duplicate items.

# Additionally, your `Market` class should have a method called `total_inventory` that reports the quantities of all items sold at the market. Specifically, it should return a hash with items as keys and quantities as values. If multiple Vendors sell the same item, the quantity listed should be the sum of all the quantities.

# Use TDD to update your `Market` class so that it responds to the following interaction pattern:


# pry(main)> market.sorted_item_list
# #=> ["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"]

# pry(main)> market.total_inventory
# #=> {#<Item:0x007f9c56740d48...> => 100, #<Item:0x007f9c565c0ce8...> => 7, #<Item:0x007f9c56343038...> => 50, #=> #<Item:0x007f9c562a5f18...> => 25}
# ```