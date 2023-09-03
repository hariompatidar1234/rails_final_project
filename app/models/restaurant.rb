class Restaurant < ApplicationRecord
    belongs_to :user
    has_many :dishes
    has_many :orders
    has_one_attached :picture
    validates :name, :status, presence: true
    validates :status, inclusion: { in: %w(open closed) } 
  
    validate :owner_only_add_restaurants
  
    # Custom validation method to ensure only owners can create restaurants
    def owner_only_add_restaurants
      unless user.type == "Owner"
        errors.add(:base, "Only Owner have permission to add restaurants.")      
      end
    end
end
