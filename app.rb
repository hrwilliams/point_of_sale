require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require('sinatra/activerecord')
require("./lib/product")
# require("./lib/purchase")
require("pg")

get('/') do
  erb(:index)
end

get('/products/new') do
  erb(:product_form)
end

post('/products') do
  name = params.fetch('name')
  price = params.fetch('price').to_f()
  @product = Product.create({:name => name, :price => price})
  erb(:product_success)
end

get('/products') do
  @products = Product.all()
  erb(:products)
end

get('/products/:id') do
  @product = Product.find(params.fetch('id').to_i())
  erb(:product)
end
