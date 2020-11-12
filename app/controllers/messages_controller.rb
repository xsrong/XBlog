class MessagesController < ApplicationController
  def new
    @to_user = User.find_by(nickname: params[:to_user_nickname])
    unless current_user.id == @to_user.id
      @message_list = current_user.related_messages(@to_user)
      @message = Message.new
    else
      redirect_to root_path, alert: "cannot send messages to yourself!!"
    end
  end

  def create
    @to_user = User.find_by(nickname: params[:to_user_nickname])
    unless current_user.id == @to_user.id
      @message = Message.new(message_params)
      @message.from_user_id = current_user.id
      @message.from_user_nickname = current_user.nickname
      @message.to_user_id = @to_user.id
      @message.to_user_nickname = @to_user.nickname
      if @message.save
        @message_list = current_user.related_messages(@to_user)
      end
    end
  end

  private
  
    def message_params
      params.require(:message).permit(:to_user_nickname, :content)
    end
end
