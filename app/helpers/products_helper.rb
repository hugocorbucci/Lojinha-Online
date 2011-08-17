module ProductsHelper
  def to_currency(price)
    number_to_currency(price, :locale => :pt, :format => "R%u %n")
  end
end
