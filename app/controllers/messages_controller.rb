class MessagesController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @messages = Message.all
    respond_to do |format|
      format.json { render json: @messages }
    end
  end

  def create
    @message = Message.new(resource_params)
    respond_to do |format|
      if @message.save
        notify_new_message
        format.json { render json: @message }
      else
        format.json { render json: { errors: @message.errors.messages }, status: 422 }
      end
    end
  end

  protected

  def resource_params
    params.require(:message).permit(:sender, :message)
  end

  def notify_new_message
    # Send notification to WebSocket channel
    ActionCable.server.broadcast(
      'chat_notifications', { type: 'new_message' }
    )
  end
end
