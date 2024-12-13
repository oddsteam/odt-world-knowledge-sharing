# frozen_string_literal: true

class SlideButtonComponent < BaseComponent
    def initialize(selected: false, model:)
        super()
        @selected = selected
        @model = model
    end
end
