class Product < ActiveRecord::Base
  validates(:name, {:presence => true, :length => { :maximum => 50}})
  validates(:price, {:presence => true, numericality: true})
end
