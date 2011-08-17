class PhotoImport
  def self.load(filepath)
    importer = PhotoImport.new(filepath)
    importer.products.each do |product_id|
      product = Product.where(:_id => product_id).first
      product = create_product(product_id) unless product

      importer.populate(product, product_id) if product
    end
  end
  
  def self.create_product(id)
    puts "Images for product with id #{id} cannot be loaded since this product does not exist. Would you like to create it? [Y|n]"
    should_create = STDIN.gets.strip != "n"
    product = nil
    if should_create
      puts "What is the product's name?"
      name = STDIN.gets.strip
      puts "What is the product's description?"
      description = STDIN.gets.strip
      puts "What is the product's price?"
      price = STDIN.gets.strip.to_i
      product = Product.create!(:_id => id, :name => name, :description => description, :price => price)
    end
    
    product
  end
  
  attr_reader :products
  
  def initialize(filepath)
    raise Exception.new("Directory '#{filepath}' does not exist.") unless Dir.exist?(filepath)
    @filepath = filepath
    @products = extract_products(@filepath)
  end
  
  def extract_products(filepath)
    photos = Dir.glob(File.join(filepath, "*-*.*"))
    photos.map{|photo| photo.match(/(\d+)-\d+\..+/)[1].to_i }.uniq
  end
  
  def populate(product, id)
    indexed_count = product.photos.size

    filenames = File.join(@filepath, to_path(id)) + "-*.*"
    photos = Dir.glob(filenames)
    photos.select{|photo| photo.match(/[^\/]*\/\d+-(\d+)\..+/)[1].to_i >= indexed_count }.each do |photo|   
      puts "Adding picture at '#{photo}' to product with id #{id}"
      product.photos << Photo.new(:image => File.new(photo))
    end
    product.save!
  end
  
  def to_path(id)
    if id < 10
      "00#{id}"
    elsif id < 100
      "0#{id}"
    else
      "#{id}"
    end
  end
end