class HomeController < ApplicationController
  def index
    redirect_to messages_url
  end

  def disconnect
    ActionCable.server.disconnect(id: '1234')
  end
end
