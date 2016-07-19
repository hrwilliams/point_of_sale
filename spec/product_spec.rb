describe(Product) do
  it("ensures the name is present") do
    product = Product.new({:name => '', :price => 1.00})
    expect(product.save()).to(eq(false))
  end
  # it("ensures the name is less than 50 characters") do
  #
  # end
  # it("ensures the price is a numerical entry") do
  #
  # end
  # it("sets the purchased value to false when initializing a product") do
  #
  # end
end
