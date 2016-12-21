namespace :product do
  desc "Loads products describe in a CSV file pointed by the 'filename' \
variable"
  task load: [:environment] do
    ProductImport.load(File.expand_path("#{Dir.pwd}/#{ENV['filename']}"))
  end

  desc 'Dumps a CSV file containing all products'
  task dump: :environment do
    puts ProductImport.dump
  end
end
