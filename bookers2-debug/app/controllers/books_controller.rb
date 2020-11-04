class BooksController < ApplicationController
before_action :authenticate_user!
before_action :edit_book, only: [:edit, :update]

  def show
    @book = Book.find(params[:id])
    @new_comment = BookComment.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @new_comment = BookComment.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def edit_book
    unless Book.find(params[:id]).user.id.to_i == current_user.id
      redirect_to books_path
    end
  end
end
