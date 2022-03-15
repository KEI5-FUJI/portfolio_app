class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @request = Request.find(params[:request_id])
    @messageroom = Messageroom.find_by(id: params[:messageroom_id])
    @message = @messageroom.messages.build(message_params)
    @message.user_id = current_user.id
    if @message.save
      redirect_to request_messageroom_url(request_id: @messageroom.request.id, id: @messageroom.id)
    else
      render "messagerooms/show"
    end
  end

  private
    def message_params
      params.require(:message).permit(:message)
    end
end
