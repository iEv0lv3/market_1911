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
