module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include GuestsHelper

    identified_by :queue_guest

    def connect
      self.queue_guest = find_verified_user
    end

    private

      def find_verified_user
        if guest_logged_in?
          current_guest
        else
          reject_unauthorized_connection
        end
      end
  end
end
