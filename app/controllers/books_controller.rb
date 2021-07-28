class BooksController < ApplicationController

  def index
    if user_signed_in?
      @book = Book.new
      @user = current_user
      @users = @book.user
      @books = Book.all
      render :index
    else
      redirect_to new_user_session_path
    end
  end

  def create

    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = 'You have created book successfully.'
       redirect_to book_path(@book)
    else
    @user = current_user
    @books = Book.all
      render :index
    end
  end

  def show

    @books = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = 'You have updated book successfully.'
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end