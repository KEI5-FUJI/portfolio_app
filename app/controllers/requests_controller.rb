class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_correct_user?, only: [:destroy]

  def index
    #2km以内にいるyユーザー一覧取得
    @latitude = params[:latitude]
    @longitude = params[:longitude]
    
    @near_users = User.all.within(2, origin: [@latitude, @longitude])
    requests_ordered = []
      #2km以内にいるユーザーのリクエスト取得
    requests_ordered = @near_users.each do |near_user|
      near_user_requests = near_user.requests
      near_user_requests.each do |near_user_request|
          requests_ordered.push(near_user_request)
      end
    end
    #リクエストをランダムに並び替え
    @requests = requests_ordered.shuffle
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

  private
    def current_user_place_params
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
