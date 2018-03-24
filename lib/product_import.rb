# frozen_string_literal: true

require 'csv'

# Helps import products from a CSV.
class ProductImport
  HEADERS = %w[_id name price description link].freeze

  def self.load(filename)
    import = new(filename)
    puts "Loaded: #{import.products.inspect}"
    import.products.each do |line|
      original = Product.where(_id: line[:_id]).first
      if original
        original.update_attributes!(line)
      else
        Product.create!(line)
      end
    end
  end

  def self.dump
    CSV.generate(encoding: 'UTF-8',
                 write_headers: true,
                 force_quotes: true,
                 headers: HEADERS) do |csv|
      Product.sorted.each do |product|
        csv << to_row(product)
      end
    end
  end

  def self.to_row(product)
    [
      product.id,
      product.name,
      product.price,
      product.description,
      product.link
    ]
  end

  IDENTITY = ->(col) { col }
  TO_PRICE = lambda do |price|
    match = price.match(/R\$ (\d+).*/)
    match ? match[1].to_i : price
  end
  CONVERTERS = [
    :integer,
    IDENTITY,
    to_price,
    IDENTITY,
    IDENTITY,
    IDENTITY,
    IDENTITY
  ].freeze
  attr_reader :products

  def initialize(filename)
    raise Exception, error_message(filename) unless File.exist?(filename)
    @products = load_csv(filename)
  end

  private

  def load_csv(filename)
    products = []
    CSV.foreach(filename,
                headers: :first_row,
                header_converters: :symbol,
                converters: CONVERTERS,
                skip_blanks: true) do |row|
      products << row.to_hash
    end
    products
  end

  def error_message(filename)
    "File '#{filename}' does not exist."
  end
end
