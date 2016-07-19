# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_for [ Message, :new ], coder: ActiveSupport::JSON do |message|
      transmit({ type: 'new_message', message: message })
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
