class MessageroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_current_user_request?, only: [:index]
  before_action :banned_current_user, only: [:create]

  def index
    @messagerooms = Request.find(params[:request_id]).messagerooms
  end

  def create
    @request = Request.find(params[:request_id])
    @messageroom = @request.messagerooms.build(owner_id: @request.user_id, guest_id: current_user.id)
    if @messageroom.save
      redirect_to request_messageroom_url(request_id: @request.id, id: @messageroom.id)
    else
      render "home_pages/mypage"
    end
  end

  def show
  end

  private
    def is_current_user_request?
      @request = current_user.requests.find_by(id: params[:request_id])
      redirect_to mypage_url if @request.nil?
    end

    def banned_current_user
      @request = current_user.requests.find_by(id: params[:request_id])
      redirect_to mypage_url unless @request.nil?
    end

end
