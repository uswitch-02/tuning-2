class Diary < ApplicationRecord

  enum is_draft: { posted: false, draft: true }
  belongs_to :customer
  has_many :comments
  has_many :favorites
  has_many :favorited_customers, through: :favorites, source: :customer

  # ...
  has_many :diary_sentiments, dependent: :destroy
  has_many :sentiments, through: :diary_sentiments, dependent: :destroy
  # ...



  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

#view画面上も、非公開になっている投稿を表示しないようにするときに使う予定
  # def posted?
    # status == 'posted'
  # end

  # 投稿検索機能（ワード検索）
  def self.search_for(search_word, method)
    if method == "parfect"
      @diary = Diary.where("title LIKE?","#{search_word}")
    elsif method == "forward"
      @diary = Diary.where("title LIKE?","#{search_word}%")
    elsif method == "backward"
      @diary = Diery.where("title LIKE?","%#{search_word}")
    elsif method == "partial"
      @diary = Diary.where("title LIKE?","%#{search_word}%")
    else
      @diary = Diary.all
    end
  end
  # def self.search_for(content, method)
  #   if method == 'perfect'
  #     Customer.where(title: content)
  #   elsif method == 'forward'
  #     Cutomer.where('title LIKE ?', content + '%')
  #   elsif method == 'backward'
  #     Customer.where('title LIKE ?', '%' + content)
  #   else
  #     Customer.where('title LIKE ?', '%' + content + '%')
  #   end
  # end
  # def self.search_for(content, method)
  #   if method == 'perfect'
  #     where(title: content)
  #   elsif method == 'partial'
  #     where('title LIKE ?', "%#{content}%")
  #   else
  #     all
  #   end
  # end
end
