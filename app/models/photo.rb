class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  embedded_in :product, :inverse_of => :photos
  
  has_mongoid_attached_file :image, :styles => { :medium => "800x600>", :thumb => "160x120>" }
  
  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 10.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
end