Product.delete_all
Category.delete_all

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
  end
end
