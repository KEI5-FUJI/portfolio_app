class HomePagesController < ApplicationController
  before_action :authenticate_user!, only: [:mypage]

  def home
  end

  def mypage
    @request = current_user.requests.build
    @requests = current_user.requests.all.order(created_at: "DESC")
    render 'home_pages/mypage'
  end
end
