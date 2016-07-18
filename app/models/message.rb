class Message < ApplicationRecord
  validates_presence_of :sender, :message
end
