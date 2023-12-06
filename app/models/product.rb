class Product < ApplicationRecord
  belongs_to :category

  validates :name, :descrption, :price, :category, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: { only_integer: true }

  def self.search(keywords)
    if keywords
      where("name LIKE ? OR descrption LIKE ?", "%#{keywords}%", "%#{keywords}%").order("id DESC")
    else
      order("id DESC")
    end
  end
end
