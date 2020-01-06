module ModeratorsHelper

    def log_in_mod(moderator)
        session[:moderator_id] = moderator.id
    end

    def current_mod
        if session[:moderator_id]
            @current_mod ||= Moderator.find_by(id: session[:moderator_id])
        end
    end

    def mod_logged_in?
        !current_mod.nil?
    end
end

