class ProfileController < ApplicationController
    def index
        @me = User.find(current_user.id)
    end
end
