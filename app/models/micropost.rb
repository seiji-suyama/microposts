class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  has_many:favorites
  
  has_many :favorite_micropost, dependent: :destroy
  has_many :favorite_users, through: :favorlite_micropost, source: :user
  
  def favorited_by? user
    favorites.where(user_id: user.id).exists?
  end
end
