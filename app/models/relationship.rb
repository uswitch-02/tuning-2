class Relationship < ApplicationRecord
  belongs_to :customer
  belongs_to :diary
  validates_uniqueness_of :diary_id, scope: :customer_id
end
