require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require 'simplecov'


SimpleCov.start

class SalesAnalystTest < Minitest::Test

  attr_accessor :sa

  def setup
    se = SalesEngine.from_csv({:items => './test/fixtures/items_100.csv',
                               :merchants => './test/fixtures/merchants_100.csv'})
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_access_merchant_repository
    assert_instance_of MerchantRepository, sa.merchant_repository
  end

  def test_all_merchants_returns_merchants
    assert_equal Array, sa.all_merchants.class
    assert_instance_of Merchant, sa.all_merchants.first
  end

  def test_count_items_per_merchant
    assert_equal Array, sa.count_items_per_merchant.class
  end

  def test_average_items_per_merchant
    assert_equal 0.78, sa.average_items_per_merchant
    assert_equal Float, sa.average_items_per_merchant.class
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal Float, sa.average_items_per_merchant_standard_deviation.class
    assert_equal 1.97, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal Array, sa.merchants_with_high_item_count.class
    assert_instance_of Merchant, sa.merchants_with_high_item_count.first
    assert_equal 9, sa.merchants_with_high_item_count.length
  end

  def test_find_merchant_by_id
    assert_equal Merchant, sa.find_merchant_by_id(12334195).class
  end
  
  def test_find_merchant_items_by_id
    assert_equal 12, sa.find_merchant_items(12334195).length
    assert_equal Array, sa.find_merchant_items(12334195).class
    assert_instance_of Item, sa.find_merchant_items(12334195).first
  end

  def average_item_price_for_merchant
    assert_instance_of Float, average_item_price_for_merchant
  end

  def test_merchant_item_prices
    assert_equal 12, sa.merchant_item_prices(12334195).length
    assert_equal Array, sa.merchant_item_prices(12334195).class
    assert_instance_of BigDecimal, sa.merchant_item_prices(12334195).first
  end

  def test_average_item_price_for_merchant
    assert_equal 449.83, sa.average_item_price_for_merchant(12334195) 
    assert_equal BigDecimal, sa.average_item_price_for_merchant(12334195).class
  end

  def test_average_item_price_for_each_merchant
    assert_equal 100, sa.average_merchant_prices.length
    assert_equal Array, sa.average_merchant_prices.class
    assert_instance_of BigDecimal, sa.average_merchant_prices.first
  end

  def test_average_average_price_per_merchant
    assert_instance_of BigDecimal, sa.average_average_price_per_merchant
    assert_equal 62.53, sa.average_average_price_per_merchant
  end

  def test_it_can_access_item_repository
    assert_instance_of ItemRepository, sa.item_repository
  end

  def test_all_items_returns_items
    assert_equal Array, sa.all_items.class
    assert_instance_of Item, sa.all_items.first
  end

  def test_find_all_item_prices
    assert_equal 100, sa.all_item_prices.length
    assert_instance_of Array, sa.all_item_prices
    assert_instance_of BigDecimal, sa.all_item_prices.first
  end

  def test_average_item_price
    assert_equal 149.31, sa.average_item_price
    assert_instance_of BigDecimal, sa.average_item_price
  end

  def test_item_price_standard_deviation
    assert_equal 341.77, sa.item_price_standard_deviation
    assert_instance_of BigDecimal, sa.item_price_standard_deviation
  end

  def test_golden_items
    assert_equal Array, sa.golden_items.class
    assert_equal 2, sa.golden_items.length
  end
end