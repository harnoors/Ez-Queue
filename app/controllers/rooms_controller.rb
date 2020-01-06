class RoomsController < ApplicationController
    #just for showing the accessCode and password once the room is created
    def show
        @room = Room.find(params[:id])
    end
    
    def new
        @room = Room.new #this will be the argument required for the form which accepts the inputted password
    end

    def create
        @room = Room.new(room_params)
        @room.accessCode  = get_unique_accessCode
        if @room.save
            redirect_to @room
        else  
            render 'new' #start process over again
        end
    end

    private

        #returns randomly generated 6 character code
        def generate_accessCode
          return ((0..9).to_a + ("a".."z").to_a).shuffle[0..5].join("")
        end

        #returns a unique access code not saved in DB currently
        def get_unique_accessCode
            code = generate_accessCode
            while Room.exists?(accessCode: code) do
                code = generate_accessCode
            end
            return code
        end

        #ensure that the user only submits a password, not an accessCode
        def room_params
            params.require(:room).permit(:password)
        end
end
