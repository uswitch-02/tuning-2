class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum is_deleted: { exist: false, withdraw: true }
  # enum is_published: { disclose: true, non_disclosure: false }
  enum is_locked: { unlook: false, look: true }

  has_many :diarys, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :favorites, dependent: :destroy
# 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
# 被フォロー関係を通じて参照⇒自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower

# 自分がフォローする側の（与フォロー）の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
# 与フォロー関係を通じて参照⇒自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

    # バリデーション
    with_options presence: true do
    validates :first_name
    validates :last_name
    validates :pen_name
    validates :email, presence: true
    validates :encrypted_password, presence: true,length: { minimum: 6 }

    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力して下さい。'} do
    validates :first_name_kana, presence: true
    validates :last_name_kana, presence: true
    end
  end

  def self.guest
    guest_email = "guest_#{SecureRandom.hex}@example.com"
    find_or_create_by!(pen_name: 'guestuser', email: guest_email, first_name: 'ユーザー', last_name: 'ゲスト', first_name_kana: 'ゲスト', last_name_kana: 'ユーザー') do |customer|
      customer.password = SecureRandom.urlsafe_base64
    end
  end


  def guest?
    # ゲストユーザーかどうかの判定
    # email がゲストユーザー用の特定の値であるかを判定する場合
    email == 'guest@example.com'
    pen_name == 'guestuser'
  end

  def full_name
    last_name + first_name
  end

  def full_name_kana
    last_name_kana + " " + first_name_kana
  end

  has_one_attached :profile_image

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
    # profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def follow(customer)
    relationships.create(followed_id: customer.id)
  end

  def unfollow(customer)
    relationships.find_by(followed_id: customer.id).destroy
  end

  def following?(customer)
    followings.include?(customer)
  end

  # ユーザ検索機能
  def self.search_for(content, method)
    if method == 'perfect'
      Customer.where(pen_name: content)
    elsif method == 'forward'
      Cutomer.where('pen_name LIKE ?', content + '%')
    elsif method == 'backward'
      Customer.where('pen_name LIKE ?', '%' + content)
    else
      Customer.where('penname LIKE ?', '%' + content + '%')
    end
  end


end
