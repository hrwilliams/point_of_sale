class Product < ActiveRecord::Base
  belongs_to(:product)
  validates(:name, {:presence => true, :length => { :maximum => 50}})
  validates(:price, {:presence => true, :numericality => { greater_than: 0 }})
  before_save(:upcase_name)

  scope(:not_purchased, -> do
    where({:purchased => false})
  end)

private

  define_method(:upcase_name) do
    self.name=(name().upcase())
  end
end
