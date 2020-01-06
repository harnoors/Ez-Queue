class PagesController < ApplicationController
    def home
    end

    #temporary landing page for both Moderator and Guest when they log in for now

    def join
        @guest = Guest.new
        @mod = Moderator.new
    end
end
