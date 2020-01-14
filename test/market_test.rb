# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/vendor'
require './lib/market'

class MarketTest < Minitest::Test
  def test_market_exists
    market = Market.new('South Pearl Street Farmers Market')

    assert_instance_of Market, market
  end

  def test_market_can_have_attributes
    market = Market.new('South Pearl Street Farmers Market')

    assert_equal 'South Pearl Street Farmers Market', market.name
    assert_equal [], market.vendors
  end

  def test_market_can_add_vendors
    market = Market.new('South Pearl Street Farmers Market')
    vendor1 = Vendor.new('Rocky Mountain Fresh')
    item1 = Item.new(name: 'Peach', price: '$0.75')
    item2 = Item.new(name: 'Tomato', price: '$0.50')
    item3 = Item.new(name: 'Peach-Raspberry Nice Cream', price: '$5.30')
    item4 = Item.new(name: 'Banana Nice Cream', price: '$4.25')

    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new('Ba-Nom-a-Nom')

    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new('Palisade Peach Shack')

    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    assert_includes(market.vendors, vendor1)
    assert_includes(market.vendors, vendor2)
    assert_includes(market.vendors, vendor3)
  end

  def test_market_can_list_vendor_names
    market = Market.new('South Pearl Street Farmers Market')
    vendor1 = Vendor.new('Rocky Mountain Fresh')
    item1 = Item.new(name: 'Peach', price: '$0.75')
    item2 = Item.new(name: 'Tomato', price: '$0.50')
    item3 = Item.new(name: 'Peach-Raspberry Nice Cream', price: '$5.30')
    item4 = Item.new(name: 'Banana Nice Cream', price: '$4.25')

    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new('Ba-Nom-a-Nom')

    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new('Palisade Peach Shack')

    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    assert_includes(market.vendor_names, 'Rocky Mountain Fresh')
    assert_includes(market.vendor_names, 'Ba-Nom-a-Nom')
    assert_includes(market.vendor_names, 'Palisade Peach Shack')
  end

  def test_market_can_list_vendors_that_sell_item
    market = Market.new('South Pearl Street Farmers Market')
    vendor1 = Vendor.new('Rocky Mountain Fresh')
    item1 = Item.new(name: 'Peach', price: '$0.75')
    item2 = Item.new(name: 'Tomato', price: '$0.50')
    item3 = Item.new(name: 'Peach-Raspberry Nice Cream', price: '$5.30')
    item4 = Item.new(name: 'Banana Nice Cream', price: '$4.25')

    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new('Ba-Nom-a-Nom')

    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new('Palisade Peach Shack')

    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    assert_includes(market.vendors_that_sell(item1), vendor1)
    assert_includes(market.vendors_that_sell(item1), vendor3)
    assert_includes(market.vendors_that_sell(item4), vendor2)
  end

  def test_market_can_create_sorted_item_list
    market = Market.new('South Pearl Street Farmers Market')
    vendor1 = Vendor.new('Rocky Mountain Fresh')
    item1 = Item.new(name: 'Peach', price: '$0.75')
    item2 = Item.new(name: 'Tomato', price: '$0.50')
    item3 = Item.new(name: 'Peach-Raspberry Nice Cream', price: '$5.30')
    item4 = Item.new(name: 'Banana Nice Cream', price: '$4.25')

    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new('Ba-Nom-a-Nom')

    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new('Palisade Peach Shack')

    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    assert_includes(market.sorted_item_list, 'Banana Nice Cream')
    assert_includes(market.sorted_item_list, 'Peach')
    assert_includes(market.sorted_item_list, 'Peach-Raspberry Nice Cream')
    assert_includes(market.sorted_item_list, 'Tomato')
  end

  def test_market_can_list_total_inventory
    market = Market.new('South Pearl Street Farmers Market')
    vendor1 = Vendor.new('Rocky Mountain Fresh')
    item1 = Item.new(name: 'Peach', price: '$0.75')
    item2 = Item.new(name: 'Tomato', price: '$0.50')
    item3 = Item.new(name: 'Peach-Raspberry Nice Cream', price: '$5.30')
    item4 = Item.new(name: 'Banana Nice Cream', price: '$4.25')

    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new('Ba-Nom-a-Nom')

    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new('Palisade Peach Shack')

    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    expected = market.total_inventory.values_at(item1)[0]
    expected2 = market.total_inventory.values_at(item2)[0]
    expected3 = market.total_inventory.values_at(item4)[0]
    expected4 = market.total_inventory.values_at(item3)[0]

    assert_equal 100, expected
    assert_equal 7, expected2
    assert_equal 50, expected3
    assert_equal 25, expected4
  end

  def test_market_can_sell_items
    item1 = Item.new(name: 'Peach', price: '$0.75')
    item2 = Item.new(name: 'Tomato', price: '$0.50')
    item3 = Item.new(name: 'Peach-Raspberry Nice Cream', price: '$5.30')
    item4 = Item.new(name: 'Banana Nice Cream', price: '$4.25')
    item5 = Item.new(name: 'Onion', price: '$0.25')

    market = Market.new('South Pearl Street Farmers Market')

    vendor1 = Vendor.new('Rocky Mountain Fresh')
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new('Ba-Nom-a-Nom')
    vendor2.stock(item4, 50)
    vendor2.stock('Peach-Raspberry Nice Cream', 25)

    vendor3 = Vendor.new('Palisade Peach Shack')
    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    assert_equal false, market.sell(item1, 200)
    assert_equal true, market.sell(item4, 5)
    assert_equal 45, vendor2.check_stock(item4)
    assert_equal true, market.sell(item1, 40)
    assert_equal 0, vendor1.check_stock(item1)
    assert_equal 60, vendor3.check_stock(item1)
  end

  def test_availability_to_sell_helper_method
    item1 = Item.new(name: 'Peach', price: '$0.75')
    item2 = Item.new(name: 'Tomato', price: '$0.50')
    item3 = Item.new(name: 'Peach-Raspberry Nice Cream', price: '$5.30')
    item4 = Item.new(name: 'Banana Nice Cream', price: '$4.25')
    item5 = Item.new(name: 'Onion', price: '$0.25')

    market = Market.new('South Pearl Street Farmers Market')

    vendor1 = Vendor.new('Rocky Mountain Fresh')
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new('Ba-Nom-a-Nom')
    vendor2.stock(item4, 50)
    vendor2.stock('Peach-Raspberry Nice Cream', 25)

    vendor3 = Vendor.new('Palisade Peach Shack')
    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    assert_equal false, market.availability_to_sell(item1, 200)
  end

  def test_remove_from_stock_helper_method
    item1 = Item.new(name: 'Peach', price: '$0.75')
    item2 = Item.new(name: 'Tomato', price: '$0.50')
    item3 = Item.new(name: 'Peach-Raspberry Nice Cream', price: '$5.30')
    item4 = Item.new(name: 'Banana Nice Cream', price: '$4.25')
    item5 = Item.new(name: 'Onion', price: '$0.25')

    market = Market.new('South Pearl Street Farmers Market')

    vendor1 = Vendor.new('Rocky Mountain Fresh')
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new('Ba-Nom-a-Nom')
    vendor2.stock(item4, 50)
    vendor2.stock('Peach-Raspberry Nice Cream', 25)

    vendor3 = Vendor.new('Palisade Peach Shack')
    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    assert_equal true, market.sell(item4, 10)
    assert_equal 40, vendor2.check_stock(item4)
    assert_equal true, market.sell(item1, 20)
    assert_equal 15, vendor1.check_stock(item1)
  end
end
