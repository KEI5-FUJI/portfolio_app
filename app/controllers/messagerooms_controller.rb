class MessageroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_current_user_request?, only: [:index]
  before_action :banned_current_user, only: [:create]
  before_action :only_owner_and_guest_user, only: [:show]

  def index
    @messagerooms = Request.find(params[:request_id]).messagerooms
  end

  def create
    @request = Request.find(params[:request_id])
    if is_request_created?(@request)
      @messageroom = @request.messagerooms.build(owner_id: @request.user_id, guest_id: current_user.id)
      if @messageroom.save
        redirect_to request_messageroom_url(request_id: @request.id, id: @messageroom.id)
      else
        render "requests/show"
      end
    else
      redirect_to mypage_url
    end
  end

  def show
    @request = Request.find_by(id: params[:request_id])
    @messageroom = Messageroom.find_by(id: params[:id])
    @messages = @messageroom.messages
    @message = @messageroom.messages.build
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

    def only_owner_and_guest_user
      @messageroom = Messageroom.find(params[:id])
      unless current_user == User.find(@messageroom.owner_id) || current_user == User.find(@messageroom.guest_id)
        redirect_to mypage_url
      end
    end

    def is_request_created?(request)
      request.messagerooms.find_by(owner_id: @request.user_id, guest_id: current_user.id).nil?
    end
end
