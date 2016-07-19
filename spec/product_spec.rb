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
  # it("sets the purchased value to false when initializing a product") do
  #
  # end
end
