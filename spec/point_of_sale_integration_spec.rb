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
    Product.create({:name => 'Lamp', :price => 12, :purchased => false})
    visit '/products'
    expect(page).to have_content 'LAMP'
  end
end

describe('update a product path', {:type => :feature}) do
  it('allows a user to view an individual product page') do
    Product.create({:name => 'lamp', :price => 12, :purchased => false})
    visit '/products'
    click_link 'LAMP'
    expect(page).to have_content 'LAMP'
  end

  it("allows the user to edit the product name")do
    Product.create({:name => 'lamp', :price => 12, :purchased => false})
    visit '/products'
    click_link 'LAMP'
    click_link 'Update LAMP Information'
    fill_in('name', :with => 'modern lamp')
    click_button 'Update'
    expect(page).to have_content 'MODERN LAMP'
  end

  it("allows the user to delete a product") do
    Product.create({:name => 'lamp', :price => 12, :purchased => false})
    visit '/products'
    click_link 'LAMP'
    click_button 'Delete LAMP'
    expect(page).to have_no_content 'LAMP'
  end
end

describe('add a purchase path', {:type => :feature}) do
  it("allows user to make a purchase") do
    Product.create({:name => 'lamp', :price => 12, :purchased => false})
    Product.create({:name => 'belt', :price => 50, :purchased => false})
    visit '/'
    click_link 'Make a Purchase'
    check('BELT: 50.00')
    click_button 'Make purchase'
    expect(page).to have_content 'Thank you for your purchase!'
  end
  it("removes purchased products from the product list") do
    Product.create({:name => 'lamp', :price => 12, :purchased => false})
    Product.create({:name => 'belt', :price => 50, :purchased => false})
    visit '/'
    click_link 'Make a Purchase'
    check('BELT: 50.00')
    click_button 'Make purchase'
    visit('/products')
    expect(page).to have_no_content 'belt'
  end
end
