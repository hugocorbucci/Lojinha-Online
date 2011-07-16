class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  
  has_mongoid_attached_file :photo, :styles => { :medium => "800x600>", :thumb => "160x120>" }
  
  field :name, :type => String
  field :price, :type => Float
  field :description, :type => String
  
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
end
