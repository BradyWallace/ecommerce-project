require "csv"
require "uri"

Product.delete_all
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='products';")
Category.delete_all
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='categories';")
Page.delete_all
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='pages';")

NUMBER_OF_CATEGORIES = 4
PRODUCTS_PER_CATEGORY = 5

NUMBER_OF_CATEGORIES.times do
  category = Category.create(name: Faker::Commerce.unique.department)

  PRODUCTS_PER_CATEGORY.times do
    product = category.products.create(
      name:       Faker::Commerce.unique.product_name,
      descrption: Faker::Hipster.sentence(word_count: rand(20..40)),
      price:      rand(5000..10_000).to_i
    )
    downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{product.name}")
    product.image.attach(io: downloaded_image, filename: "m-#{product.name}.jpg")
    puts(product.name, " created")
  end
end

Province.create(
  name: "Alberta",
  pst:  0.00,
  gst:  0.05,
  hst:  0.00
)
Province.create(
  name: "British Columbia",
  pst:  0.07,
  gst:  0.05,
  hst:  0.00
)
Province.create(
  name: "Manitoba",
  pst:  0.07,
  gst:  0.05,
  hst:  0.00
)
Province.create(
  name: "New Brunswick",
  pst:  0.00,
  gst:  0.00,
  hst:  0.15
)
Province.create(
  name: "Newfoundland and Labrador",
  pst:  0.00,
  gst:  0.00,
  hst:  0.15
)
Province.create(
  name: "Northwest Territories",
  pst:  0.00,
  gst:  0.05,
  hst:  0.00
)
Province.create(
  name: "Nova Scotia",
  pst:  0.00,
  gst:  0.00,
  hst:  0.15
)
Province.create(
  name: "Nunavut",
  pst:  0.00,
  gst:  0.05,
  hst:  0.00
)
Province.create(
  name: "Ontario",
  pst:  0.00,
  gst:  0.00,
  hst:  0.13
)
Province.create(
  name: "Prince Edward Island",
  pst:  0.00,
  gst:  0.00,
  hst:  0.13
)
Province.create(
  name: "Quebec",
  pst:  0.10,
  gst:  0.05,
  hst:  0.00
)
Province.create(
  name: "Saskatchewan",
  pst:  0.06,
  gst:  0.05,
  hst:  0.00
)
Province.create(
  name: "Yukon",
  pst:  0.00,
  gst:  0.05,
  hst:  0.00
)

Page.create(
  title:     "About Us",
  content:   "The data that powers this website is fake and untrustworthy. It was provided by faker, though.",
  permalink: "about"
)
Page.create(
  title:     "Contact Us",
  content:   "If you like this website please reach out to fakeemail@devandb.com",
  permalink: "contact"
)
AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password") if Rails.env.development?
