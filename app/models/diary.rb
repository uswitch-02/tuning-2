class Diary < ApplicationRecord
  
  enum is_draft: { posted: false, draft: true }
  belongs_to :customer
  has_many :comments
  has_many :favorites
  has_many :favorited_customers, through: :favorites, source: :customer


  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
