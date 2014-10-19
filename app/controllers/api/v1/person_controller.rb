class Api::V1::PersonController < ApplicationController
  respond_to :json

  def index
    respond_with(Person.all)
  end

  def show
    respond_with(Person.find(params[:id]))
  end

end
