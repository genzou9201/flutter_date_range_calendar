class CalendarRepository {
  static int? tappedDay;
  static DateTime? selectedStartDate;
  static DateTime? selectedEndDate;

  static void onTapDay(DateTime tappedDate) {
    print('CalendarRepository.onTapDay()');
    if (selectedStartDate != null &&
        selectedEndDate == null &&
        tappedDate.isAtSameMomentAs(selectedStartDate!)) {
      selectedStartDate = null;
      return;
    }
    if (selectedStartDate == null) {
      selectedStartDate = tappedDate;
      return;
    }
    if (tappedDate.isBefore(selectedStartDate!)) {
      selectedStartDate = tappedDate;
      return;
    }
    if (selectedEndDate != null &&
        tappedDate.isAtSameMomentAs(selectedEndDate!)) {
      selectedEndDate = null;
      return;
    }
    if (tappedDate.isAfter(selectedStartDate!)) {
      selectedEndDate = tappedDate;
      return;
    }
  }
}

String getMonthString(DateTime date) {
  switch (date.month) {
    case DateTime.january:
      return 'January';
    case DateTime.february:
      return 'February';
    case DateTime.march:
      return 'March';
    case DateTime.april:
      return 'April';
    case DateTime.may:
      return 'May';
    case DateTime.june:
      return 'June';
    case DateTime.july:
      return 'July';
    case DateTime.august:
      return 'August';
    case DateTime.september:
      return 'September';
    case DateTime.october:
      return 'October';
    case DateTime.november:
      return 'November';
    case DateTime.december:
      return 'December';
    default:
      return 'Null';
  }
}

String getDayOfTheWeekString(DateTime date) {
  switch (date.month) {
    case DateTime.january:
      return 'January';
    case DateTime.february:
      return 'February';
    case DateTime.march:
      return 'March';
    case DateTime.april:
      return 'April';
    case DateTime.may:
      return 'May';
    case DateTime.june:
      return 'June';
    case DateTime.july:
      return 'July';
    case DateTime.august:
      return 'August';
    case DateTime.september:
      return 'September';
    case DateTime.october:
      return 'October';
    case DateTime.november:
      return 'November';
    case DateTime.december:
      return 'December';
    default:
      return 'Null';
  }
}
