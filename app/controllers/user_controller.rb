class UserController < ApplicationController

  private

  def user_params
    params.require(:user).permit(:profession)
  end
end


