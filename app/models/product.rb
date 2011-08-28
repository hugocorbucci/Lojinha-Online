class Product
  include Mongoid::Document
  include Mongoid::Search
  include Mongoid::Timestamps
  
  embeds_many :photos
  
  search_in :name, :description
  
  field :id, :type => Integer
  field :name, :type => String
  field :price, :type => Integer
  field :description, :type => String
  field :sold, :type => Boolean
  
  validates_presence_of :id, :name, :price
  
  scope :sorted, order_by(:_id => :asc)
  scope :available, where(:sold.ne => true)
  scope :sold, where(sold: true)

  def sell_to(name)
    self[:buyer] = name
    self.sold = true
    self.save!
  end
end

