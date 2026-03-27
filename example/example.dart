import 'package:date_range_calendar/date_range_calendar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ExamplePage());
  }
}

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DateRangeCalendar Example')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Basic usage
            DateRangeCalendar(
              onTappedDay: (start, end) {
                debugPrint('start: $start, end: $end');
              },
            ),
            const SizedBox(height: 32),

            /// Custom usage with Japanese labels
            DateRangeCalendar(
              onTappedDay: (start, end) {
                debugPrint('start: $start, end: $end');
              },
              setupData: CalendarSetupData(
                dayCellStyle: const DayCellStyle(
                  backgroundColorOfStartDay: Colors.blue,
                  backgroundColorOfEndDay: Colors.red,
                  backgroundColorOfBetweenDay: Colors.yellow,
                  borderColorOfToday: Colors.purple,
                  borderRadius: Radius.circular(6),
                ),
                monthLayoutType: MonthLayoutType.yearMonth,
                monthTitleYearUnit: '\u5e74',
                monthLabelsData: const MonthLabelsData(
                  jan: '1\u6708',
                  feb: '2\u6708',
                  mar: '3\u6708',
                  apr: '4\u6708',
                  may: '5\u6708',
                  jun: '6\u6708',
                  jul: '7\u6708',
                  aug: '8\u6708',
                  sep: '9\u6708',
                  oct: '10\u6708',
                  nov: '11\u6708',
                  dec: '12\u6708',
                ),
                dayOfTheWeekLabelsData: const DayOfTheWeekLabelsData(
                  mon: '\u6708',
                  tue: '\u706b',
                  wed: '\u6c34',
                  thu: '\u6728',
                  fri: '\u91d1',
                  sat: '\u571f',
                  sun: '\u65e5',
                ),
                initialMonth: DateTime(2024, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
