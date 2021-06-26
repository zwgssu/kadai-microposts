class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
  
  #お気に入り機能ここから
  has_many :favorites, dependent: :destroy
  has_many :likers, through: :favorites, source: :user
end
