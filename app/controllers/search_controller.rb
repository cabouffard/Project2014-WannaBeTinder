class SearchController < ApplicationController
  def index
    @professions = User::PROFESSIONS
    @users = User.where("profession = '#{params[:profession]}' AND id != #{current_user.id}") if params[:profession]
  end
end
