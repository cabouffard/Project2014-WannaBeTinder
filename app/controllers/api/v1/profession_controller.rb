class Api::V1::ProfessionController < Api::V1::BaseApiController
  include ProfessionHelper

  def index
    render json: { message: User.professions.map{|type| type } }, status: :ok
  end
end

