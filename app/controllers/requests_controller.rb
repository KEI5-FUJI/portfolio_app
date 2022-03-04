class RequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @near_users = User.all.within(2, origin: [current_user.lat, current_user.lng])
  end

  def show
  end

  def create
  end

  def destroy
  end

  def nearusers
    #緯度
    latitude = params[:latitude]
    #経度
    longitude = params[:longitude]
    #現在のユーザーの現在地の緯度と経度を保存。
    current_user.update_attributes(lat: latitude, lng: longitude)
  end
end
