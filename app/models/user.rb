class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #11,15行目はどのカラムを参照するか、13、17行目は参照カラムをもとに関連するuser_idも参照できるようにする
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 被フォロー関係を通じて参照→followed_idをフォローしている人
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 【class_name: "Relationship"】は省略可能
  has_many :followings, through: :relationships, source: :followed
  # 与フォロー関係を通じて参照→follower_idをフォローしている人
  #これらを記述することで@user.followersという記述がコントローラーで使えるようになる
  
  #フォロー機能部分↓
  def follow(user_id)
    unless self == user_id
      self.relationships.find_or_create_by(followed_id: user_id.id)
      #フォローしようとしている user_ が自分自身ではないかを検証
    end
  end
  
  def unfollow(user_id)
    relationship = self.relationships.find_by(followed_id: user_id.id)
    relationship.destroy if relationship
    #relationship が存在すれば destroy
  end
  
  def following?(user)
    followings.include?(user)
  end


  attachment :profile_image

  validates :name, presence: true, uniqueness: true, length: {in:2..20}
  validates :introduction, length: {maximum:50}

end

