class Order < ApplicationRecord
  belongs_to :user
  has_many :orderdishes
  has_many :dishes, through: :orderdishes

end
