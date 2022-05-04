class BooksController < ApplicationController
  # DEBUG - REMOVE FOR PRODUCTION!!!
  # skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_auth
  before_action :set_book, only: [:show, :update, :destroy, :edit]
  before_action :set_authors, only: [:new, :edit]

  def index
    @books = Book.all
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    book = Book.create!(book_params)
    redirect_to book
  end

  def edit
  end



  def update
    @book.update(book_params)
    redirect_to @book
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def check_auth
    authorize Book
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def set_authors
    @authors = Author.order(:last_name)
  end

  def book_params
    return params.require(:book).permit(:title, :author_id)
  end
end
