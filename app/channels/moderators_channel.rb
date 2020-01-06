class ModeratorsChannel < ApplicationCable::Channel

    def subscribed
      stream_from "moderators_channel_#{queue_guest.accessCode}"
    end
  
    def unsubscribed
      # Any cleanup needed when channel is unsubscribed
    end
  end
  