require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require('sinatra/activerecord')
require("./lib/product")
require("./lib/purchase")
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
  purchased = false
  @product = Product.create({:name => name, :price => price, :purchased => purchased})
  erb(:product_success)
end

get('/products') do
  @products = Product.not_purchased()
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

delete('/products/:id') do
  product = Product.find(params.fetch('id').to_i())
  product.destroy()
  @products = Product.all()
  erb(:products)
end

get('/purchases/new') do
  @products = Product.not_purchased()
  erb(:purchase_form)
end

post('/purchases') do
  product_ids = params.fetch("product_ids")
  @products = []
  product_ids.each() do |product_id|
    product = Product.find(product_id)
    @products.push(product)
  end
  total_price = 0
  @products.each() do |product|
    total_price = total_price.+(product.price())
  end
  date_of_purchase = DateTime.now().to_date()
  @purchase = Purchase.create({:date_of_purchase => date_of_purchase, :total_price => total_price})
  erb(:purchase_receipt)
end
