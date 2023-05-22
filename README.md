## Features

- Show a calendar to pick range of dates.
  
  ![demo 0](https://github.com/genbow3/flutter_date_range_calendar/raw/main/assets/readme/demo-0.gif)
  ![demo 1](https://github.com/genbow3/flutter_date_range_calendar/raw/main/assets/readme/demo-1.gif)


<br>
<br>

## Usage

### Basic

Import this package in your file you want to use.<br/>
Then, place `DateRangeCalendar` widget wherever you want to declare.

You need to pass a callback function `onTappedDay` of type `Function(DateTime?, DateTime?)`.

```dart
  void onTappedDay(DateTime? s, DateTime? e) {
    // handle tapped start date and tapped end date here.
    print('$s, $e');
    ...
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

<br>

### Custom

Also, you can change styles etc.

```dart
  final mySetupData = CalendarSetupData(
    // Day cell style
    dayCellStyle: const calendar.DayCellStyle(
      backgroundColorOfStartDay: Colors.blue,
      backgroundColorOfEndDay: Colors.red,
      backgroundColorOfBetweenDay: Colors.yellow,
      borderColorOfToday: Colors.purple,
      borderRadius: Radius.circular(6),
    ),

    // Other styles etc.
    monthLayoutType: MonthLayoutType.yearMonth,
    monthTitleYearUnit: '年',
    monthLabelsData: const MonthLabelsData(jan: '1月', feb: '2月'),
    dayOfTheWeekLabelsData: const DayOfTheWeekLabelsData(
      mon: '月', tue: '火', wed: '水', thu: '木', fri: '金', sat: '土', sun: '日'),
    initialMonth: DateTime(2023, 1),
  ),

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