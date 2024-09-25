class CalendarService
    # create
    #
    # Provide a calendar information of the given month/year.
    # Parameter month_year is in YYYYMM format, YYYY is Christian Era.
    def create_calendar_data(month_year = "")
        today = Date.current
        target_date = today.beginning_of_month
        current_calendar_month = "%d%02d" % [target_date.year, target_date.month]
        current_date = "%d%02d%02d" % [today.year, today.month, today.day]
        unless month_year == ""
            month = month_year[-2..-1].to_i
            year = month_year[0..3].to_i
            target_date = Date.new(year, month, 1)
        end
        end_of_month = target_date.end_of_month

        month = target_date.month
        year = target_date.year

        prev_month = month - 1
        if prev_month < 1
            prev_calendar_month = "%d%02d" % [year - 1, 12]
        else
            prev_calendar_month = "%d%02d" % [year, prev_month]
        end

        next_month = month + 1
        if next_month > 12
            next_calendar_month = "%d%02d" % [year + 1, 1]
        else
            next_calendar_month = "%d%02d" % [year, next_month]
        end

        calendar = {
            month: target_date.month,
            year: target_date.year,
            prev: prev_calendar_month,
            next: next_calendar_month,
            current: current_calendar_month,
            today: current_date,
            calendar: []
        }

        # First week of this month, may be including with the last few days of last month
        # if the first day of this month is not Sunday.
        first_week_of_this_month = []
        wday = target_date.wday
        if wday > 0
            (1..wday).each do |days_ago|
                first_week_of_this_month.unshift(target_date - days_ago)
            end
        end
        (wday..6).each do |days_ahead|
            first_week_of_this_month << (target_date + days_ahead - wday)
        end
        calendar[:calendar] << first_week_of_this_month

        week = []
        last_date_in_first_week = calendar[:calendar][0][-1]
        (last_date_in_first_week + 1..end_of_month).each do |date_in_month|
            week << date_in_month
            if date_in_month.wday == 6
                calendar[:calendar] << week
                week = []
            end
        end

        # Last week of this month, may be including with the first few days of next month
        # if the last day of this month is not Saturday
        unless week.size == 0
            wday = week[-1].wday
            (wday+1..6).each do |days_ahead|
                week << week[-1] + 1
            end
            calendar[:calendar] << week
        end

        return calendar
    end
end