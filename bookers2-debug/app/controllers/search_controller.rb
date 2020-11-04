class SearchController < ApplicationController

  def search
    @range = params[:range]
    search = params[:search_method]
    @search_word = params[:search_word]

    if @range == '1'
      @users = User.search(search,@search_word)
    end
    
    if @range == '2'
      @books = Book.search(search,@search_word)
    end
  end
end