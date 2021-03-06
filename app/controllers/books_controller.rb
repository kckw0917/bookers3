class BooksController < ApplicationController
  before_action :authenticate_user!

  def create #エラーを表示するためにインスタンス変数を使っています
  	@book = Book.new(book_params)
    @user = current_user         #user.idを渡すこと！
    @book.user_id = @user.id
      if @book.save
        redirect_to @book, notice: "Book created successfully"
      else
        @books = Book.search(params[:search])
        render :index
      end
  end

  def index
    @book = Book.new
    @books = Book.search(params[:search])
    @user = current_user
  end

  def show
    @book = Book.new
    @book_show = Book.find(params[:id])
    @user = @book_show.user
    @comment = BookComment.new
  end

  def edit
  	@book = Book.find(params[:id])
  	redirect_to book_path(@book.id) unless @book.user_id == current_user.id
  end

  def update #エラーを表示するためにインスタンス変数を使っています
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice: "Book updated successfully"
    else
      render :edit
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



