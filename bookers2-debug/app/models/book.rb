class Book < ApplicationRecord
	

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  
  
  def self.search(search_method, search_word)
    if search_method == "parfect_match"
      @books = Book.where("#{search_word}")
    elsif search_method == "forward_match"
      @books = Book.where("title LIKE?", "#{search_word}%")
    elsif search_method == "backward_match"
      @books = Book.where("title LIKE?", "%#{search_word}")
    elsif search_method == "partial_match"
      @books = Book.where("title LIKE?", "%#{search_word}%")
    else
      @books = Book.all
    end
  end
end
