class MessagesController < ApplicationController
  def index
    @messages = Message.all
    respond_to do |format|
      format.json { render json: @messages }
    end
  end

  def create
    @message = Message.new(params[:message])
    respond_to do |format|
      if @message.save
        format.json { render json: @message }
      else
        format.json { render json: { errors: @message.errors.messages }, status: :unprocessible_entity }
      end
    end
  end
end
