class UserController < ApplicationController

  def update_denied_profiles
    current_user.denied_users += [params[:user_id]]
    current_user.save
    get_new_user
  end

  def clear_denied_profiles
    current_user.denied_users = []
    current_user.save
  end

  def clear_contacted_profiles
    current_user.contacted_users = []
    current_user.conversations.delete_all
    current_user.save
  end

  def notify_user
    @to = User.find(params[:user_id])
    current_user.contacted_users += [@to.id]
    current_user.save
    @conversation = current_user.user_conversations.build
    @conversation.build_conversation
    @conversation.to = @to
    @conversation.save!
    get_new_user
  end

  private

  def user_params
    params.require(:user).permit(:profession)
  end

  def get_new_user
      if current_user.denied_users.any? || current_user.contacted_users.any?
        @user = User.where(profession: user_params[:profession])
                      .where().not(id: current_user.id)
                      .where('id NOT IN (?)', current_user.denied_users + current_user.contacted_users).limit(1).first
      else
        @user = User.where(profession: user_params[:profession])
            .where().not(id: current_user.id).limit(1).first
      end
  end
end
