class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    0 if @inventory[item].nil?
  end

  def stock(item, amount)
    @inventory[item] += amount
  end
end


# The Market will need to keep track of its Vendors and their Items. Each Vendor will be able to report its total inventory, stock items, and return the quantity of items. Any item not in stock should return `0` by default.

# Use TDD to create a `Vendor` class that responds to the following interaction pattern:


# pry(main)> vendor.check_stock(item1)
# #=> 0

# pry(main)> vendor.stock(item1, 30)

# pry(main)> vendor.inventory
# #=> {#<Item:0x007f9c56740d48...> => 30}

# pry(main)> vendor.check_stock(item1)
# #=> 30

# pry(main)> vendor.stock(item1, 25)

# pry(main)> vendor.check_stock(item1)
# #=> 55

# pry(main)> vendor.stock(item2, 12)

# pry(main)> vendor.inventory
# #=> {#<Item:0x007f9c56740d48...> => 55, #<Item:0x007f9c565c0ce8...> => 12}
# ```