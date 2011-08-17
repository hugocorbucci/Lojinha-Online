require 'csv'

class ProductImport
  def self.load(filename)
    import = ProductImport.new(filename)
    puts "Loaded: #{import.products.inspect}"
    import.products.each do |product|
      product.save unless Product.where(:_id => product.id).first
    end
  end
  
  attr_reader :products
  
  def initialize(filename)
    raise Exception.new("File '#{filename}' does not exist.") unless File.exist?(filename)
    @products = load_csv(filename)
  end
  
  def load_csv(filename)
    products = []
    identity = lambda{|col| col}
    to_price = lambda{|price| match = price.match(/R\$ (\d+).*/); match ? match[1].to_i : price}
    CSV.foreach(filename, :headers => :first_row, :header_converters => :symbol, :converters => [:integer, identity, to_price, identity, identity, identity, identity], :skip_blanks => true) do |row|
      puts "Trying to load row #{row.to_hash.inspect}"
      product = Product.new(row.to_hash)
      products << product if product.valid?
    end
    products
  end
end