class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_correct_user?, only: [:destroy]

  def index
    #2km以内にいるyユーザー一覧取得
    @near_users = User.all.within(2, origin: [current_user.lat, current_user.lng])
    requests_ordered = []
    #2km以内にいるユーザーのリクエスト取得
    requests_ordered = @near_users.each do |near_user|
       near_user_requests = near_user.requests
       near_user_requests.each do |near_user_request|
         @requests.push(near_user_request)
       end
    end
    #リクエストをランダムに並び替え
    @requests = @requests.shuffle
  end

  def show
    #リクエスト取得
    @request = Request.find(params[:id])
  end

  def create
    @request = current_user.requests.build(request_params)
    if @request.save
      redirect_to mypage_url
    else
      render "home_pages/mypage"
    end
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    #ユーザーページに移動
    redirect_to mypage_url
  end

  def nearusers
    #緯度
    latitude = params[:latitude]
    #経度
    longitude = params[:longitude]
    #現在のユーザーの現在地の緯度と経度を保存。
    current_user.update_attributes(lat: latitude, lng: longitude)
  end

  private
    def request_params
      params.require(:request).permit(:request_name, :request_detail, :reward)
    end

    def is_correct_user?
      @request = current_user.requests.find_by(id: params[:id])
      redirect_to mypage_url if @request.nil?
    end
end
