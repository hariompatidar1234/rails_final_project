class Category < ApplicationRecord
  has_many :dishes, dependent: :nullify

  validates :name, presence: true, uniqueness: true
end
s
