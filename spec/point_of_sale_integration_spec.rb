require('spec_helper')
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

  it('allows the user to view a list of products') do
    Product.create({:name => 'Lamp', :price => 12})
    visit '/products'
    expect(page).to have_content 'Lamp'
  end
end

describe('update a product path', {:type => :feature}) do
  it('allows a user to view an individual product page') do
    Product.create({:name => 'lamp', :price => 12})
    visit '/products'
    click_link 'lamp'
    expect(page).to have_content 'lamp'
  end

  it("allows the user to edit the product name")do
    Product.create({:name => 'lamp', :price => 12})
    visit '/products'
    click_link 'lamp'
    click_link 'Update lamp Information'
    fill_in('name', :with => 'mid-century modern lamp')
    click_button 'Update'
    expect(page).to have_content 'mid-century modern lamp'
  end
end
