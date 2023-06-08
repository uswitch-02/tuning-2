class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum is_deleted: { exist: false, withdraw: true }
  enum is_published: { disclose: true, non_disclosure: false }
  enum is_locked: { unlook: false, look: true }
  
  has_many :, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy

  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :pen_name, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true,length: { minimum: 6 }

end
