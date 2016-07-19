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
