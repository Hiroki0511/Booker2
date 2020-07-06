class BooksController < ApplicationController

  before_action :authenticate_user!

  def index
  	@books = Book.all
    @book = Book.new
    @user = current_user
  end

  def create
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
  	if @book.save
  		 redirect_to book_path(@book.id), notice: "Book was successfully created."
  	else
      @user = current_user
      @books = Book.all
  	  render action: :index
  	end
  end

  def show
  	@book = Book.find(params[:id])
    #@user = @book.user
  end
  
  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
    else
       redirect_to books_path
    end
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  	   redirect_to book_path(@book.id), notice: "Book was successfully updated."
    else
       render action: :edit
    end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path,notice: "Book was successfully destroyed."
  end

private

  def book_params
	  params.require(:book).permit(:title, :body, :user_id)
  end
end
