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


  validate :validate_sentiment_count
  validates :title,presence:true,length:{maximum:50}
  validates :body,presence:true,length:{maximum:100}

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



  private

  def validate_sentiment_count
    max_tags = 3
    if sentiment_ids.count > max_tags
      errors.add(:base, "選択できる個数は#{max_tags}個までです")
    end
  end
end
