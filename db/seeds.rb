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

# Products from CSV
# filename = Rails.root.join("db/prods.csv")
# prods_data = File.read(filename)
# products = CSV.parse(prods_data, headers: true, encoding: "utf-8")

# category = Category.create(name: "Construction")

# products.each do |product|
#   prod = category.products.create(
#     name:       product["name"],
#     descrption: product["descrption"],
#     price:      product["price"].to_i
#   )
#   puts(prod.name, " created")
# end

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
