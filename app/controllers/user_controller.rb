class UserController < ApplicationController

  def index
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:profession)
  end
end


