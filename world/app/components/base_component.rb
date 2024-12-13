# frozen_string_literal: true

class BaseComponent < ViewComponent::Base
    def initialize
        @guid = component_guid()
    end

    def component_guid()
        "comp_#{SecureRandom.uuid.gsub('-', '')}"
    end
end
