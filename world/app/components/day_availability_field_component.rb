# frozen_string_literal: true

class DayAvailabilityFieldComponent < BaseComponent
  def initialize(label:, selected:, model:)
    super()
    @label = label
    @selected = selected
    @model = model
  end
end
