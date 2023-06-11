class Diary < ApplicationRecord
  
  enum is_draft: { posted: false, draft: true }
  belongs_to :customer
  has_many :comments
  has_many :favorites
  has_many :favorited_customers, through: :favorites, source: :customer


  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
  
  # 投稿検索機能（ワード検索）
  def self.looks(search, word)
    if seartch == "parfect_match"
      @diary = Diary.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @diary = Diary.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @diary = Diery.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @diary = Diary.where("title LIKE?","%#{word}%")
    else
      @diary = Diary.all
    end
  end
end
