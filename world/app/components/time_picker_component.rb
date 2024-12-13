# frozen_string_literal: true

class TimePickerComponent < BaseComponent
    def initialize(model:, default: 0)
        super()
        @model = model
        @selectable_time = time_range()
        @default = default
    end

    # range_from is number of minutes since 12:00AM
    # range_to is number of minutes since 12:00AM
    # returns a list of minute stamp since 12:00AM
    def time_range(range_from = 0, range_to = 1439, step_size = 15)
        (range_from.to_i..range_to.to_i).step(step_size)
    end

    def time_format(time)
        ampm = time >= 720 ? "pm" : "am"
        time %= 720

        minutes = time % 60
        hours = (time - minutes) / 60
        if hours == 0
            hours = 12
        end

        "%02d:%02d%s" % [ hours, minutes, ampm ]
    end
end
