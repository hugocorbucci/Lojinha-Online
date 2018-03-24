# frozen_string_literal: true

# Represents a picture of a product
class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  FILE_PATH = "#{Rails.env}/:attachment/:id/:style/:filename"

  embedded_in :product, inverse_of: :photos

  has_mongoid_attached_file :image,
                            storage: :s3,
                            bucket: ENV['S3_BUCKET'],
                            s3_credentials: {
                              access_key_id: ENV['S3_KEY'],
                              secret_access_key: ENV['S3_SECRET']
                            },
                            path: FILE_PATH,
                            styles: { medium: '800x600>', thumb: '160x120>' }

  validates_attachment_presence :image
  validates_attachment_size :image, less_than: 10.megabytes
  validates_attachment_content_type :image,
                                    content_type: ['image/jpeg', 'image/png']
end
