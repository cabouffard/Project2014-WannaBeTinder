class SearchController < ApplicationController
  def index
    @professions = User.professions

    # @users = User.where("profession = '#{params[:profession]}'
    #                       AND id != #{current_user.id}
    #                       AND id NOT IN (#{current_user.denied_users.join(',')}")
    #                       .limit(4) if params[:profession]
    if params[:profession]
      if current_user.denied_users.any?
        @users = User.where(profession: params[:profession])
                      .where().not(id: current_user.id)
                      .where('id NOT IN (?)', current_user.denied_users).limit(4)
      else
        @users = User.where(profession: params[:profession])
                      .where().not(id: current_user.id).limit(4)
      end
    end
  end
end
