require 'csv'

class ProductImport
  def self.load(filename)
    import = self.new(filename)
    puts "Loaded: #{import.products.inspect}"
    import.products.each do |line|
      unless original = Product.where(:_id => line[:_id]).first
        product = Product.new(line)
        product.save!
      else
        original.update_attributes!(line)
      end
    end
  end

  def self.dump
    CSV.generate(encoding: "UTF-8", write_headers: true, force_quotes: true, headers: %w[_id name price description link]) do |csv|
      Product.sorted.each do |product|
        csv << [product.id, product.name, product.price, product.description, product.link]
      end
    end
  end
  
  attr_reader :products
  
  def initialize(filename)
    raise Exception.new("File '#{filename}' does not exist.") unless File.exist?(filename)
    @products = load_csv(filename)
  end
  
 private
  def load_csv(filename)
    products = []
    identity = lambda{|col| col}
    to_price = lambda{|price| match = price.match(/R\$ (\d+).*/); match ? match[1].to_i : price}
    CSV.foreach(filename, :headers => :first_row, :header_converters => :symbol, :converters => [:integer, identity, to_price, identity, identity, identity, identity], :skip_blanks => true) do |row|
      formatted = row.to_hash
      products << formatted
    end
    products
  end
end
