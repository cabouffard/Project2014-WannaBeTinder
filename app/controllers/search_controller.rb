class SearchController < ApplicationController

  def index
    @professions = User.professions

    if params[:profession]
      if current_user.denied_users.any? || current_user.contacted_users.any?
        @user = User.where(profession: params[:profession])
                      .where().not(id: current_user.id)
                      .where('id NOT IN (?)', current_user.denied_users + current_user.contacted_users).limit(1).first
      else
        @user = User.where(profession: params[:profession])
            .where().not(id: current_user.id).limit(1).first
      end
      if @user.nil?
        flash.now[:warning] = t("search.no_results", profession: view_context.profession_type_to_text(params[:profession]))
      end
    end

  end
end
