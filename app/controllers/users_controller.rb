class UsersController < ApplicationController

  def index
    
    if user_signed_in?
      @users = User.all
      @user = current_user
      @book = Book.new
      render :index
    else
      redirect_to new_user_session_path
    end

  end

  def create
    # @user = User.find(params[:id])
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = 'You have created user successfully.'
      redirect_to book_path(@book)
    else
    @user = current_user
    @books = Book.all
      render :index
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end

  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'You have updated user successfully.'
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render :edit
    end
  end


  def user_params
    params.require(:user).permit(:profile_image,:introduction,:name)
  end
end
