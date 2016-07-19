require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('add a product path', {:type => :feature}) do
  it('adds a product') do
    visit('/')
    click_link 'Add a Product'
    fill_in('name', :with => 'lamp')
    fill_in('price', :with => '50')
    click_button('Add Product')
    expect(page).to have_content 'Success'
  end

  it('allows the user to view a list of divisions') do
    Product.create({:name => 'Lamp', :price => 12})
    visit '/products'
    expect(page).to have_content 'Lamp'
  end
end
