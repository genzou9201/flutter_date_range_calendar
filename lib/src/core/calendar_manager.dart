import 'package:date_range_calendar/src/data/calendar_store.dart';

class CalendarManager {
  DateTime? get selectedStartDate => CalendarStore().selectedStartDate;
}