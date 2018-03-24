# frozen_string_literal: true

# Helpers for product display
module ProductsHelper
  def to_currency(price)
    number_to_currency(price,
                       locale: :pt,
                       format: 'R%<unit>u %<number>n',
                       separator: ',',
                       delimiter: '.')
  end
end
