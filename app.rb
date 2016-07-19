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

get('/products/:id/edit') do
  @product = Product.find(params.fetch('id').to_i())
  erb(:product_edit)
end

patch('/products/:id') do
  @product = Product.find(params.fetch('id').to_i())
  name = params.fetch('name')
  if name.==('')
    name = @product.name()
  end
  price = params.fetch('price').to_i()
  if price.!=(0)
    price = @product.price()
  end
  purchased = @product.purchased()
  @product.update({:name => name, :price => price, :purchased => purchased})
  erb(:product)
end
