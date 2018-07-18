class BooksController < ApplicationController
  before_action :authenticate_user!

  def create
  	book = Book.new(book_params)
    user = current_user         #user.idを渡すこと！
    book.user_id = user.id
      if book.save
        redirect_to book_path(book)
      else
        render 'show'
      end
  end

  def index
    @book = Book.new
    @user = current_user
  	@books = Book.all
  end

  def show
    @book = Book.new
    @book_show = Book.find(params[:id])
    @user = @book_show.user
  end

  def edit
  	@book = Book.find(params[:id])
  	if @book.user_id != current_user.id
  	  redirect_to book_path(@book.id)
  	end
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      redirect_to book_path(book)
    else
      render 'show'
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

    private

      def book_params
        params.require(:book).permit(:title, :body)
      end



end



