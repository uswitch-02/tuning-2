class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :diary
  validates :body, presence: true, length: { maximum: 300 }
end
