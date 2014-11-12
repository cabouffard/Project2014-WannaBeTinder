class Api::V1::UserController < Api::V1::BaseApiController

  def index
    respond_with(User.all)
  end

  def show
    respond_with(User.find(params[:id]))
  end

end
