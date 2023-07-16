class Sentiment < ApplicationRecord
  # validate :validate_tag_count, on: :create
  # ...
  has_many :diary_sentiments, dependent: :destroy
  has_many :diaries, through: :diary_sentiments, dependent: :destroy
  # ...
  private

  # def validate_tag_count
  #   max_tags = 3 # 最大タグ数を設定する
  #   errors.add(:base, "は#{max_tags}個までしか追加できません") if Tag.count >= max_tags
  # end

end