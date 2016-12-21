# Helpers for product display
module ProductsHelper
  def to_currency(price)
    number_to_currency(price,
                       locale: :pt,
                       format: 'R%u %n',
                       separator: ',',
                       delimiter: '.')
  end
end
