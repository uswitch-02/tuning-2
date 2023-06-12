class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :diary
  validates :comment, presence: true, length: { maximum: 300 }
end
