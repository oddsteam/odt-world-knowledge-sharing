module AuthenticationConcern
    extend ActiveSupport::Concern
    include SessionHelper

    included do
        before_action :require_login
    end

    private
        def require_login
            unless logged_in?
                redirect_to login_path # Adjust 'login_path' to your actual login route
            end
        end
end