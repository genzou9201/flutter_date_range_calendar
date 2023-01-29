import 'package:date_range_calendar/src/data/calendar_setup_data.dart';

class CalendarRepository {
  static int? tappedDay;
  static DateTime? selectedStartDate;
  static DateTime? selectedEndDate;

  static void onTapDay(DateTime tappedDate) {
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

String getMonthString(CalendarSetupData setupData, DateTime date) {
  switch (date.month) {
    case DateTime.january:
      return setupData.monthLabelsData.jan;
    case DateTime.february:
      return setupData.monthLabelsData.feb;
    case DateTime.march:
      return setupData.monthLabelsData.mar;
    case DateTime.april:
      return setupData.monthLabelsData.apr;
    case DateTime.may:
      return setupData.monthLabelsData.may;
    case DateTime.june:
      return setupData.monthLabelsData.jun;
    case DateTime.july:
      return setupData.monthLabelsData.jul;
    case DateTime.august:
      return setupData.monthLabelsData.aug;
    case DateTime.september:
      return setupData.monthLabelsData.sep;
    case DateTime.october:
      return setupData.monthLabelsData.oct;
    case DateTime.november:
      return setupData.monthLabelsData.nov;
    case DateTime.december:
      return setupData.monthLabelsData.dec;
    default:
      return 'Null';
  }
}
