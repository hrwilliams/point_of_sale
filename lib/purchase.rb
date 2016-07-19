class Purchase < ActiveRecord::Base
  has_many(:products)

  # define_method(:calculate_total) do |products|
  #   total = 0
  #   products.each() do |product|
  #     total = total.+(product.price())
  #   end
  #   total
  # end
end
