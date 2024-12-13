import { Controller } from "@hotwired/stimulus"

const DAY_NAMES = [
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday"
];

const ABBR_DAY_NAMES = [
  "Sun",
  "Mon",
  "Tue",
  "Wed",
  "Thu",
  "Fri",
  "Sat"
];

const MONTH_NAMES = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];

const ABBR_MONTH_NAMES = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];

// Connects to data-controller="calendar"
export default class extends Controller {
  static targets = [ 'currentMonth', 'weekList', 'dayEntry', 'date', 'currentMonthDayTemplate', 'otherMonthDayTemplate' ];
  static values = { month: Number, year: Number, identifier: String };

  connect() {
    this.currentDate = new Date();
    this.month = this.monthValue;
    this.year = this.yearValue;
    this.calendar = [];
    this.renderCalendar();
  }

  next() {
    this.month++;
    if (this.month > 12) {
      this.year++;
      this.month-=12;
    }
    this.renderCalendar();
  }

  previous() {
    this.month--;
    if (this.month <= 0) {
      this.year--;
      this.month+=12;
    }
    this.renderCalendar();
  }

  today() {
    this.month = this.currentDate.getMonth() + 1;
    this.year = this.currentDate.getFullYear();
    this.renderCalendar();
  }

  day_trigger(event) {
    this.dispatch('selected', { detail: { date: event.params.date, month: event.params.month, year: event.params.year }, prefix: this.identifierValue});
  }

  renderCalendar() {
    this.calendar = this.generateCalendar(this.year, this.month);

    this.currentMonthTarget.textContent = `${this.calendar.current.abbrMonthName} ${this.calendar.current.year}`;

    this.weekListTarget.replaceChildren();
    this.calendar.calendar.forEach((week) => {
      const tr = document.createElement('tr');
      week.forEach((day) => {
        const dayEntryNode = day.currentMonth?this.currentMonthDayTemplateTarget.content.cloneNode(true):this.otherMonthDayTemplateTarget.content.cloneNode(true);
        const dayEntry = dayEntryNode.querySelector("[data-calendar-target='day-entry']");
        dayEntry.setAttribute('data-calendar-year-param', day.year);
        dayEntry.setAttribute('data-calendar-month-param', day.month);
        dayEntry.setAttribute('data-calendar-date-param', day.date);

        const dateTarget = dayEntry.querySelector("[data-calendar-target='date']"); 
        dateTarget.textContent = day.date;
        if (day.date === this.currentDate.getDate()
          && day.month === this.currentDate.getMonth() + 1
          && day.year === this.currentDate.getFullYear()) {
          dateTarget.classList.remove('bg-transparent');
          dateTarget.classList.add('bg-red-400', 'text-gray-100');
        }
        tr.appendChild(dayEntryNode);
      })
      this.weekListTarget.appendChild(tr);
    });
  }

  generateCalendar(year, month) {
    const firstDay = (new Date(year, month - 1)).getDay(); // Day of week (0-6)
    const daysInMonth = 32 - new Date(year, month - 1, 32).getDate();
    const daysInPreviousMonth = 32 - new Date(year, month - 2, 32).getDate();

    let calendar = [];
    let currentWeek = [];
    let prevMonthDate = daysInPreviousMonth - firstDay + 1;
    let prevMonthMonth = month - 1;
    let prevMonthYear = year;
    if (prevMonthMonth <= 0) {
      prevMonthMonth += 12;
      prevMonthYear--;
    }
    let nextMonthMonth = month + 1;
    let nextMonthYear = year;
    if (nextMonthMonth > 12) {
      nextMonthMonth -= 12;
      prevMonthYear++;
    }

    // Add days from the previous month to complete the first week (if needed)
    for (let i = 0; i < firstDay; i++) {
      currentWeek.push({ date: prevMonthDate, month: prevMonthMonth, year: prevMonthYear, currentMonth: false });
      prevMonthDate++;
    }

    for (let i = 1; i <= daysInMonth; i++) {
      currentWeek.push({ date: i, month: month, year: year, currentMonth: true });

      if (currentWeek.length === 7) {
        calendar.push(currentWeek);
        currentWeek = []; 
      }
    }

    // Add days from the next month to complete the last week (if needed)
    if (currentWeek.length > 0) {
      for (let i = currentWeek.length, date = 1; i < 7; i++, date++) {
        currentWeek.push({ date: date, month: nextMonthMonth, year: nextMonthYear, currentMonth: false });
      }
      calendar.push(currentWeek);
    }

    return {
      now: {
        day: this.currentDate.getDay(),
        dayName: DAY_NAMES[this.currentDate.getDay()],
        abbrDayName: ABBR_DAY_NAMES[this.currentDate.getDay()],
        date: this.currentDate.getDate(),
        month: this.currentDate.getMonth() + 1,
        year: this.currentDate.getFullYear(),
        monthName: MONTH_NAMES[this.currentDate.getMonth()],
        abbrMonthName: ABBR_MONTH_NAMES[this.currentDate.getMonth()]
      },
      current: {
        month: month,
        year: year,
        monthName: MONTH_NAMES[month - 1],
        abbrMonthName: ABBR_MONTH_NAMES[month - 1]
      },
      previous: {
        month: prevMonthMonth,
        year: prevMonthYear,
        monthName: MONTH_NAMES[prevMonthMonth - 1],
        abbrMonthName: ABBR_MONTH_NAMES[prevMonthMonth - 1]
      },
      next: {
        month: nextMonthMonth,
        year: nextMonthYear,
        monthName: MONTH_NAMES[nextMonthMonth - 1],
        abbrMonthName: ABBR_MONTH_NAMES[nextMonthMonth - 1]
      },
      calendar: calendar
    };
  }
}
