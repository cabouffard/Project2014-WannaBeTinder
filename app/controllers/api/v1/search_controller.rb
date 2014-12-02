class Api::V1::SearchController < Api::V1::BaseApiController
  def index
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
        render json: { error: 'No results' }, status: :ok
      else
        render json: @user, status: :ok
      end
    end
  end
end
