require "csv"

Product.delete_all
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='products';")
Category.delete_all
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='categories';")

NUMBER_OF_CATEGORIES = 4
PRODUCTS_PER_CATEGORY = 25

NUMBER_OF_CATEGORIES.times do
  category = Category.create(name: Faker::Commerce.unique.department)

  PRODUCTS_PER_CATEGORY.times do
    product = category.products.create(
      name:       Faker::Commerce.unique.product_name,
      descrption: Faker::Hipster.sentence(word_count: rand(20..40)),
      price:      rand(5000..10_000).to_i
    )
    puts(product.name, " created")
  end
end

# Products from CSV
filename = Rails.root.join("db/prods.csv")
prods_data = File.read(filename)
products = CSV.parse(prods_data, headers: true, encoding: "utf-8")

category = Category.create(name: "Construction")

products.each do |product|
  prod = category.products.create(
    name:       product["name"],
    descrption: product["descrption"],
    price:      product["price"].to_i
  )
  puts(prod.name, " created")
end
