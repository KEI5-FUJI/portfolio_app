class HomePagesController < ApplicationController
  before_action :authenticate_user!, only: [:mypage]
  before_action :banned_logged_user, only: [:home]

  def home
  end

  def mypage
    @request = current_user.requests.build
    @requests = current_user.requests.all.order(created_at: "DESC")
    render 'home_pages/mypage'
  end

  def made_messageroom
    @messagerooms = Messageroom.where("guest_id = ?", current_user.id)
  end

  def make_messageroom
    @messagerooms = Messageroom.where("owner_id = ?", current_user.id)
  end

  private 
    def banned_logged_user
      if user_signed_in?
        redirect_to mypage_url
      end
    end
end
