class Api::V1::ProfessionController < Api::V1::BaseApiController
  include ProfessionHelper

  def index
    render json: { message: User.professions.map{|type| [type, profession_type_to_text(type)] } }, status: :ok
  end
end

