class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_correct_user?, only: [:destroy]

  def index
    #2km以内にいるyユーザー一覧取得
    @near_users = User.all_user_minus_one_user(current_user).within(2, origin: [current_user.lat, current_user.lng])
    #2km以内にいるユーザーのリクエスト取得
    near_users_requests=[]
    @near_users.each do |near_user|
      near_users_requests = near_users_requests + near_user.requests
    end
    #リクエストをランダムに並び替え
    @requests = near_users_requests.shuffle
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

  def save_current_location
    #緯度
    latitude = params[:latitude]
    #経度
    longitude = params[:longitude]
    #現在のユーザーの現在地の緯度と経度を保存。
    if current_user.update(lat_and_lng_params)
      redirect_to requests_url
    else
      render "requests/index"
    end
  end

  private
    def lat_and_lng_params
      params.permit(:lat, :lng)
    end

    def request_params
      params.require(:request).permit(:request_name, :request_detail, :reward)
    end

    def is_correct_user?
      @request = current_user.requests.find_by(id: params[:id])
      redirect_to mypage_url if @request.nil?
    end
end
