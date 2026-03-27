import 'package:date_range_calendar/src/data/calendar_setup_data.dart';

String getMonthString(CalendarSetupData setupData, DateTime date) =>
    switch (date.month) {
      DateTime.january => setupData.monthLabelsData.jan,
      DateTime.february => setupData.monthLabelsData.feb,
      DateTime.march => setupData.monthLabelsData.mar,
      DateTime.april => setupData.monthLabelsData.apr,
      DateTime.may => setupData.monthLabelsData.may,
      DateTime.june => setupData.monthLabelsData.jun,
      DateTime.july => setupData.monthLabelsData.jul,
      DateTime.august => setupData.monthLabelsData.aug,
      DateTime.september => setupData.monthLabelsData.sep,
      DateTime.october => setupData.monthLabelsData.oct,
      DateTime.november => setupData.monthLabelsData.nov,
      DateTime.december => setupData.monthLabelsData.dec,
      _ => 'Null',
    };
