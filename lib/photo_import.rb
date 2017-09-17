# Helps importing pictures from the filesystem.
class PhotoImport
  def self.load(filepath)
    importer = PhotoImport.new(filepath)
    importer.products.each do |product_id|
      product = Product.where(_id: product_id).first
      product ||= create_product(product_id)

      importer.populate(product, product_id) if product
    end
  end

  def self.create_product(id)
    puts "Images for product with id #{id} cannot be loaded since this \
product does not exist. Would you like to create it? [Y|n]"
    should_create = STDIN.gets.strip != 'n'

    build_product(id) if should_create
  end

  def self.build_product(id)
    puts "What is the product's name?"
    name = STDIN.gets.strip
    puts "What is the product's description?"
    description = STDIN.gets.strip
    puts "What is the product's price?"
    price = STDIN.gets.strip.to_i
    Product.create!(_id: id, name: name, description: description, price: price)
  end

  attr_reader :products

  def initialize(filepath)
    raise Exception, error_message(filepath) unless Dir.exist?(filepath)
    @filepath = filepath
    @products = extract_products(@filepath)
  end

  def extract_products(filepath)
    photos = Dir.glob(File.join(filepath, '*-*.*'))
    photos.map { |photo| photo.match(/(\d+)-\d+\..+/)[1].to_i }.uniq.sort
  end

  def populate(product, id)
    photo_filepaths = photo_files_for(id)
    photos = to_product_photos(photo_filepaths, product.photos.size)
    photos.each do |photo|
      puts "Adding picture at '#{photo.image.path}' to product with id #{id}"
      product.photos << photo
    end
    product.save!
  end

  def to_path(id)
    if id < 10
      "00#{id}"
    elsif id < 100
      "0#{id}"
    else
      id.to_s
    end
  end

  private

  def to_product_photos(filepaths, indexed_count)
    sorted_matching_files = filepaths.select do |filepath|
      filepath.match(%r{[^/]*/\d+-(\d+)\..+})[1].to_i > indexed_count
    end.sort
    sorted_matching_files.map do |filepath|
      Photo.new(image: File.new(filepath))
    end
  end

  def photo_files_for(id)
    filenames = File.join(@filepath, to_path(id)) + '-*.*'
    Dir.glob(filenames)
  end

  def error_message(filepath)
    "Directory '#{filepath}' does not exist."
  end
end
