class Api::V1::UserController < Api::V1::BaseApiController
  include ActionView::Helpers::NumberHelper

  def index
    respond_with(User.all)
  end

  def show
    if params[:id].to_i == @current_user.id.to_i
      render json: User.find(params[:id])
    else
      render json: { error: 'Unable to access private information' }, status: :unauthorized
    end
  end

  def update_denied_profiles
    @current_user.denied_users += [params[:user_id]]
    @current_user.save

    get_new_user
  end

  def notify_user
    @to = User.find(params[:user_id])
    @current_user.contacted_users += [@to.id]
    @current_user.save
    @conversation = @current_user.user_conversations.build
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
      if @current_user.denied_users.any? || @current_user.contacted_users.any?
        @user = User.where(profession: user_params[:profession])
                      .where().not(id: @current_user.id)
                      .where('id NOT IN (?)', @current_user.denied_users + @current_user.contacted_users).limit(1).first
      else
        @user = User.where(profession: user_params[:profession])
            .where().not(id: @current_user.id).limit(1).first
      end
      render json: { error: 'No results' }, status: :ok if @user.nil?

      @user.distance_to_text = "#{t("users.profile.around")} #{number_to_human(@current_user.distance_to([@user.latitude, @user.longitude]) * 1000, units: :distance, precision: 1)}" if @user.has_gps_location? && @current_user.has_gps_location?
      render json: @user, status: :ok, serializer: PublicUserSerializer
  end
end
