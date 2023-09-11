class Order < ApplicationRecord
  belongs_to :user
  has_many :orderdishes,dependent: :nullify
  has_many :dishes, through: :orderdishes

end
