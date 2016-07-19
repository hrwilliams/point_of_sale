require('spec_helper')
describe(Product) do
  it("ensures the name is present") do
    product = Product.new({:name => ''})
    expect(product.save()).to(eq(false))
  end
  it("ensures the name is less than 50 characters") do
    product = Product.new({:name => "a".*(51)})
    expect(product.save()).to(eq(false))
  end
  it("ensures the price is a numerical entry") do
    product = Product.new({:name => 'lamp', :price => 'lamp'})
    expect(product.save()).to(eq(false))
  end
  it("ensures the price is greater than 0") do
    product = Product.create({:name => 'lamp', :price => 0})
    expect(product.save()).to(eq(false))
  end
  it("capitalizes every letter of product") do
    product = Product.create({:name => 'lamp', :price => 12})
    expect(product.name()).to(eq("LAMP"))
  end
  describe(".not_purchased") do
    it("returns the products not purchased") do
      not_purchased_product1 = Product.create({:name => "lamp", :price => 50, :purchased => false })
      not_purchased_product2 = Product.create({:name => "desk", :price => 50, :purchased => false })
      not_purchased_products = [not_purchased_product1, not_purchased_product2]
      purchased_product = Product.create({:name => "belt", :price => 8, :purchased => false})
      purchased_product.update({:name => "belt", :price => 8, :purchased => true})
      expect(Product.not_purchased()).to(eq(not_purchased_products))
    end
  end
end
