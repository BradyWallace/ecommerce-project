class Product < ApplicationRecord
  belongs_to :category

  def self.search(keywords)
    if keywords
      where("name LIKE ? OR descrption LIKE ?", "%#{keywords}%", "%#{keywords}%"").order('id DESC'")
    else
      order("id DESC")
    end
  end
end
