require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'item'
require_relative 'csv_parser'
require_relative 'merchant'

class SalesEngine

  include CsvParser

  attr_reader :merchants,
              :items
      
  def initialize(files = {})
    @merchants = create_merchant_repository(files)
    @items = create_item_repository(files)
  end

  def self.from_csv(files)
    new(files)
  end

  def create_merchant_repository(files)
    if files.include?(:merchants)
      MerchantRepository.new(open_file(files[:merchants]), self)
    end
  end

  def create_item_repository(files)
    if files.include?(:items)
      ItemRepository.new(open_file(files[:items]), self)
    end
  end
end