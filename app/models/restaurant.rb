class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :dishes, dependent: :destroy
  has_one_attached :picture
  validates :name, :status, :address, presence: true
  validates :status, inclusion: { in: %w[open closed] }
  validates :name, uniqueness: true
  # validate :owner_only_add_restaurants

  # private 

  # def owner_only_add_restaurants
  #   return if user.type == 'Owner'
  #   errors.add(:base, 'Only Owner have permission to add restaurants.')
  # end
end
