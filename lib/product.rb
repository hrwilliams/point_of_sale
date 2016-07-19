class Product < ActiveRecord::Base
  validates(:name, {:presence => true, :length => { :maximum => 50}})
  validates(:price, {:presence => true, :numericality => { greater_than: 0 }})
  after_create(:purchase_false)

  scope(:not_purchased, -> do
    where({:purchased => false})
  end)

private

  define_method(:purchase_false) do
    self.purchased=(false)
  end
end
