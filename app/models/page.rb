class Page < ApplicationRecord
  validates :title, :content, :permalink, presence: true
  validates :title, :permalink, uniqueness: true
end
