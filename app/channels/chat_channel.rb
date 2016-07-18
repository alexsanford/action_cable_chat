# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatChannel < ApplicationCable::Channel
  def subscribed
    puts 'Subscribed!!!'
    stream_from "chat_notifications"
  end

  def unsubscribed
    puts 'Unsubscribed!!!'
    # Any cleanup needed when channel is unsubscribed
  end

  def new_message
    puts 'New Message!!!'
  end
end
