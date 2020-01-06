class GuestsController < ApplicationController
    def create
        @guest = Guest.new(guest_params)
        @mod = Moderator.new #need to create a new mod in case we get redirected back to join - guests/join requires it for form

        if !Room.exists?(@guest.accessCode)
            @guest.errors.add(:accessCode, message: "Cannot find access code.")
            render 'pages/join'
        elsif !@guest.save
            render 'pages/join'
        else
            log_in_guest @guest
            redirect_to guest_url
        end
    end

    private

        def guest_params
            params.require(:guest).permit(:accessCode)
        end
end
