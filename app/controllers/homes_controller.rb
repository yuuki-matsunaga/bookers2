class HomesController < ApplicationController

  def index
    if user_signed_in?
    redirect_to user_path(current_user.id)
    else
    render :index
    end
  end

  def about
  end

  # def destroy
  #   redirect_to root_path
  # end

end
