class ModeratorsController < ApplicationController
    

    def create
        @mod = Moderator.new(mod_params)
        @guest = Guest.new ##need to create a new mod in case we get redirected back to join - guests/join requires it for form

        if !Room.exists?(@mod.accessCode)
            @mod.errors.add(:accessCode, message: "Cannot find access code.")
            render 'pages/join'
        elsif Room.find(@mod.accessCode).password != @mod.virtual_password
            @mod.errors.add(:virtual_password, message: "Password is not correct.")
            render 'pages/join'
        elsif !@mod.save
            render 'pages/join'
        else
            log_in_mod @mod
            redirect_to mod_url
        end
    end

    def modQueue
        
    end

    def shutdown
        @mod = Moderator.find_by(id: session[:moderator_id]);
        @guest = Guest.find_by(id: session[:guest_id]);
        
        guestsInQueue =  Guest.where(accessCode: @mod.accessCode)
        if guestsInQueue.size > 0
            ActionCable.server.broadcast "moderators_channel_#{@mod.accessCode}", modName: @mod.name #broadcast that Queue is shut down
        end
        Room.delete((@mod.accessCode))
        redirect_to join_url
    end

    def next
        @mod = Moderator.find_by(id: session[:moderator_id]);
        guestsInQueue = Guest.where(accessCode: @mod.accessCode)
        if guestsInQueue.size > 0
            logger.debug guestsInQueue.order(:created_at).first
            guestsInQueue.order(:created_at).first.destroy #remove next person from the queue 
            ActionCable.server.broadcast "queue_channel_#{@mod.accessCode}", modName: @mod.name #broadcast mod name so it can be displayed if user pos is 1
        end
    end
    

        def mod_params
            params.require(:moderator).permit(:name, :accessCode, :virtual_password)
        end
end
