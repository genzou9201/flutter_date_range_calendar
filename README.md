# date_range_calendar

[![pub package](https://img.shields.io/pub/v/date_range_calendar.svg)](https://pub.dev/packages/date_range_calendar)
[![pub points](https://img.shields.io/pub/points/date_range_calendar)](https://pub.dev/packages/date_range_calendar/score)
[![pub likes](https://img.shields.io/pub/likes/date_range_calendar)](https://pub.dev/packages/date_range_calendar)
[![pub popularity](https://img.shields.io/pub/popularity/date_range_calendar)](https://pub.dev/packages/date_range_calendar/score)

A Flutter widget for selecting a range of dates from a calendar.

## Features

- Single month and double month calendar layouts
- Fully customizable colors, labels, and border radius
- Localization support (e.g. Japanese month/weekday labels)
- Configurable month title layout (month-year or year-month)

![demo 0](https://github.com/genbow3/flutter_date_range_calendar/raw/main/assets/readme/demo-0.gif)
![demo 1](https://github.com/genbow3/flutter_date_range_calendar/raw/main/assets/readme/demo-1.gif)

## Installation

```bash
flutter pub add date_range_calendar
```

## Usage

### Basic

```dart
import 'package:date_range_calendar/date_range_calendar.dart';

void onTappedDay(DateTime? s, DateTime? e) {
  print('$s, $e');
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: DateRangeCalendar(
        onTappedDay: onTappedDay,
      ),
    ),
  );
}
```

### Custom

```dart
final mySetupData = CalendarSetupData(
  dayCellStyle: const DayCellStyle(
    backgroundColorOfStartDay: Colors.blue,
    backgroundColorOfEndDay: Colors.red,
    backgroundColorOfBetweenDay: Colors.yellow,
    borderColorOfToday: Colors.purple,
    borderRadius: Radius.circular(6),
  ),
  monthLayoutType: MonthLayoutType.yearMonth,
  monthTitleYearUnit: '年',
  monthLabelsData: const MonthLabelsData(jan: '1月', feb: '2月'),
  dayOfTheWeekLabelsData: const DayOfTheWeekLabelsData(
    mon: '月', tue: '火', wed: '水', thu: '木', fri: '金', sat: '土', sun: '日'),
  initialMonth: DateTime(2023, 1),
);

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: DateRangeCalendar(
        onTappedDay: onTappedDay,
        setupData: mySetupData,
      ),
    ),
  );
}
```

## License

MIT
