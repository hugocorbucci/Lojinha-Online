# Represents the model for a product
class Product
  include Mongoid::Document
  include Mongoid::Search
  include Mongoid::Timestamps

  embeds_many :photos

  search_in :name, :description

  field :id, type: Integer
  field :name, type: String
  field :price, type: Integer
  field :description, type: String
  field :buyer, type: String
  field :sold, type: Boolean, default: false
  field :paid, type: Boolean, default: false
  field :delivered, type: Boolean, default: false

  validates_presence_of :id, :name, :price

  scope :sorted, -> { order_by(_id: :asc) }
  scope :available, -> { where(:sold.ne => true) }
  scope :sold, -> { where(sold: true) }
  scope :pending_payment, -> { where(sold: true, paid: false) }
  scope :pending_delivery, -> { where(sold: true, delivered: false) }

  def sell_to(name)
    self[:buyer] = name
    self.sold = true
    self[:paid] = false
    self[:delivered] = false
    save!
  end

  def pay
    self.paid = true
    save!
  end

  def deliver
    self.delivered = true
    save!
  end
end
