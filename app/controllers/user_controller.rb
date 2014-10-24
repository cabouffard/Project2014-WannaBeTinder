class UserController < ApplicationController

  def update_denied_profiles
    @position = params[:position]
    current_user.denied_users += [params[:user_id]]
    current_user.save

    if current_user.denied_users.any?
      @user = User.where(profession: user_params[:profession])
                    .where().not(id: current_user.id)
        .where('id NOT IN (?)', current_user.denied_users).limit(1).first
    else
      @user = User.where(profession: user_params[:profession])
        .where().not(id: current_user.id).limit(1).first
    end
  end

  def clear_denied_profiles
    current_user.denied_users = []
    current_user.save
  end

  private

  def user_params
    params.require(:user).permit(:profession)
  end
end


