class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
 
  
  
  has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  
  
  
  
  attachment :profile_image

  validates :name, presence: true, length: { in: 2..20}
  validates :introduction, length: {maximum: 50}
  
  def follow(other_user)
    following << other_user
  end

  
  def unfollow(other_user)
    
    active_relationships.find_by(followed_id: other_user.id).destroy
  end


  def following?(other_user)
    following.include?(other_user)
  end
   
   
  def self.search(search_method, search_word)
    if search_method == "perfect_match"
      @users = User.where(name: search_word)
    elsif search_method == "forward_match"
      @users = User.where("name LIKE?", "#{search_word}%")
    elsif search_method == "backward_match"
      @users = User.where("name LIKE?", "%#{search_word}")
    elsif search_method == "partial_match"
      @users = User.where("name LIKE?", "%#{search_word}%")
    else
      @users = User.all
    end
  end
  
end
