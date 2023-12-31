class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :fields, dependent: :destroy
         has_many :field_comments, dependent: :destroy
         has_many :favorites, dependent: :destroy
         
         has_many :group_customers, dependent: :destroy
         # 自分がフォローされる（被フォロー）側の関係性
         has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
        # 被フォロー関係を通じて参照→自分をフォローしている人
         has_many :followers, through: :reverse_of_relationships, source: :follower

        # 自分がフォローする（与フォロー）側の関係性
        has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
        # 与フォロー関係を通じて参照→自分がフォローしている人
         has_many :followings, through: :relationships, source: :followed
        has_many :read_counts, dependent: :destroy
  has_one_attached :profile_image

  #validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  #validates :introduction, length: { maximum: 50 }


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.png'
  end

  def follow(customer)
    relationships.create(followed_id: customer.id)
  end

  def unfollow(customer)
    relationships.find_by(followed_id: customer.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Customer.where(name: content)
    elsif method == 'forward'
      Customer.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Customer.where('name LIKE ?', '%' + content)
    else
      Customer.where('name LIKE ?', '%' + content + '%')
    end
  end

end
