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
end
