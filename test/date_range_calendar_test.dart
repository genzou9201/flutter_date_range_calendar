import 'package:date_range_calendar/date_range_calendar.dart';
import 'package:date_range_calendar/src/core/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<CalendarSetupData>()])
void main() {
  late CalendarSetupData testSetupData;
  late Function(DateTime?, DateTime?) onTappedDay;

  setUp(() {
    testSetupData = CalendarSetupData(
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
    onTappedDay = (DateTime? s, DateTime? e) {};
  });

  group('デフォルトデータ：', () {
    late CalendarSetupData defaultSetupData;
    late DateTime dateTimeNow;
    late String monthTitle;
    late String calendarTitle;

    setUp(() {
      defaultSetupData = const CalendarSetupData();
      dateTimeNow = DateTime.now();
      monthTitle = getMonthString(defaultSetupData, dateTimeNow);
      calendarTitle =
          '$monthTitle ${dateTimeNow.year}${defaultSetupData.monthTitleYearUnit}';
    });

    group('セットアップされたデータの使用：', () {
      testWidgets('年月日タイトル表記が正しい', (widgetTester) async {
        await widgetTester.pumpWidget(TestMyApp(onTappedDay: onTappedDay));
        expect(find.text(calendarTitle), findsOneWidget);
      });

      testWidgets('曜日表記が正しい', (widgetTester) async {
        await widgetTester.pumpWidget(TestMyApp(onTappedDay: onTappedDay));

        expect(find.text('Mon'), findsOneWidget);
        expect(find.text('Tue'), findsOneWidget);
        expect(find.text('Wed'), findsOneWidget);
        expect(find.text('Thu'), findsOneWidget);
        expect(find.text('Fri'), findsOneWidget);
        expect(find.text('Sat'), findsOneWidget);
        expect(find.text('Sun'), findsOneWidget);
      });

      testWidgets('すべての日の表記が正しい', (widgetTester) async {
        await widgetTester.pumpWidget(TestMyApp(onTappedDay: onTappedDay));
        expect(find.text('0'), findsNothing);
        for (var i = 1; i <= 31; i++) {
          expect(find.text('$i'), findsOneWidget);
        }
        expect(find.text('32'), findsNothing);
      });
    });

    testWidgets('次の月の表示が正しい', (widgetTester) async {
      await widgetTester.pumpWidget(TestMyApp(onTappedDay: onTappedDay));
      expect(find.text(calendarTitle), findsOneWidget);
      await widgetTester.tap(find.byIcon(Icons.keyboard_arrow_right));
      await widgetTester.pump();
      expect(find.text(calendarTitle), findsNothing);
    });

    testWidgets('前の月の表示が正しい', (widgetTester) async {
      await widgetTester.pumpWidget(TestMyApp(onTappedDay: onTappedDay));
      expect(find.text(calendarTitle), findsOneWidget);
      await widgetTester.tap(find.byIcon(Icons.keyboard_arrow_left));
      await widgetTester.pump();
      expect(find.text(calendarTitle), findsNothing);
    });

    testWidgets('description', (widgetTester) async {
      await widgetTester.pumpWidget(TestMyApp(onTappedDay: onTappedDay));
    });
  });

  group('カスタムデータ：', () {
    group('セットアップされたデータの使用：', () {
      testWidgets('年月日タイトル表記が正しい', (widgetTester) async {
        await widgetTester.pumpWidget(TestMyApp(
          onTappedDay: onTappedDay,
          setupData: testSetupData,
        ));

        expect(find.text('2023年 1月'), findsOneWidget);
      });

      testWidgets('曜日表記が正しい', (widgetTester) async {
        await widgetTester.pumpWidget(TestMyApp(
          onTappedDay: onTappedDay,
          setupData: testSetupData,
        ));

        expect(find.text('月'), findsOneWidget);
        expect(find.text('火'), findsOneWidget);
        expect(find.text('水'), findsOneWidget);
        expect(find.text('木'), findsOneWidget);
        expect(find.text('金'), findsOneWidget);
        expect(find.text('土'), findsOneWidget);
        expect(find.text('日'), findsOneWidget);
      });
    });
  });
}

class TestMyApp extends StatelessWidget {
  const TestMyApp({
    required this.onTappedDay,
    this.setupData = const CalendarSetupData(),
    super.key,
  });

  final Function(DateTime?, DateTime?) onTappedDay;
  final CalendarSetupData setupData;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: DateRangeCalendar(
          setupData: setupData,
          onTappedDay: onTappedDay,
        ),
      ),
    );
  }
}
