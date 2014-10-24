class SearchController < ApplicationController
  def index
    @professions = User.professions

    # @users = User.where("profession = '#{params[:profession]}'
    #                       AND id != #{current_user.id}
    #                       AND id NOT IN (#{current_user.denied_users.join(',')}")
    #                       .limit(4) if params[:profession]
    if params[:profession]
      if current_user.denied_users.any?
        @user = User.where(profession: params[:profession])
                      .where().not(id: current_user.id)
          .where('id NOT IN (?)', current_user.denied_users).limit(1).first
      else
        @user = User.where(profession: params[:profession])
          .where().not(id: current_user.id).limit(1).first
      end
    end
  end
end
