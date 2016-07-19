class Product < ActiveRecord::Base
  belongs_to(:product)
  validates(:name, {:presence => true, :length => { :maximum => 50}})
  validates(:price, {:presence => true, :numericality => { greater_than: 0 }})

  scope(:not_purchased, -> do
    where({:purchased => false})
  end)

end
