import 'package:date_range_calendar/date_range_calendar.dart';
import 'package:date_range_calendar/src/core/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CalendarSetupData testSetupData;
  late void Function(DateTime?, DateTime?) onTappedDay;

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

  group('日付選択ロジック：', () {
    // 2023年1月を固定で使用（1日は日曜日）
    late CalendarSetupData setupData;

    setUp(() {
      setupData = CalendarSetupData(
        initialMonth: DateTime(2023, 1),
      );
    });

    testWidgets('日付タップで開始日が選択される', (widgetTester) async {
      DateTime? capturedStart;
      DateTime? capturedEnd;

      await widgetTester.pumpWidget(TestMyApp(
        onTappedDay: (s, e) {
          capturedStart = s;
          capturedEnd = e;
        },
        setupData: setupData,
      ));

      await widgetTester.tap(find.text('10'));
      await widgetTester.pump();

      expect(capturedStart, DateTime(2023, 1, 10));
      expect(capturedEnd, isNull);
    });

    testWidgets('開始日の後の日付タップで終了日が選択される', (widgetTester) async {
      DateTime? capturedStart;
      DateTime? capturedEnd;

      await widgetTester.pumpWidget(TestMyApp(
        onTappedDay: (s, e) {
          capturedStart = s;
          capturedEnd = e;
        },
        setupData: setupData,
      ));

      await widgetTester.tap(find.text('10'));
      await widgetTester.pump();
      await widgetTester.tap(find.text('20'));
      await widgetTester.pump();

      expect(capturedStart, DateTime(2023, 1, 10));
      expect(capturedEnd, DateTime(2023, 1, 20));
    });

    testWidgets('開始日を再タップで選択解除される', (widgetTester) async {
      DateTime? capturedStart;
      DateTime? capturedEnd;

      await widgetTester.pumpWidget(TestMyApp(
        onTappedDay: (s, e) {
          capturedStart = s;
          capturedEnd = e;
        },
        setupData: setupData,
      ));

      await widgetTester.tap(find.text('10'));
      await widgetTester.pump();
      // 同じ日を再タップ
      await widgetTester.tap(find.text('10'));
      await widgetTester.pump();

      expect(capturedStart, isNull);
      expect(capturedEnd, isNull);
    });

    testWidgets('終了日を再タップで終了日のみ解除される', (widgetTester) async {
      DateTime? capturedStart;
      DateTime? capturedEnd;

      await widgetTester.pumpWidget(TestMyApp(
        onTappedDay: (s, e) {
          capturedStart = s;
          capturedEnd = e;
        },
        setupData: setupData,
      ));

      // 開始日→終了日を設定
      await widgetTester.tap(find.text('10'));
      await widgetTester.pump();
      await widgetTester.tap(find.text('20'));
      await widgetTester.pump();

      // 終了日を再タップ
      await widgetTester.tap(find.text('20'));
      await widgetTester.pump();

      expect(capturedStart, DateTime(2023, 1, 10));
      expect(capturedEnd, isNull);
    });

    testWidgets('開始日と終了日が選択済みの状態で開始日を再タップで全解除される', (widgetTester) async {
      DateTime? capturedStart;
      DateTime? capturedEnd;

      await widgetTester.pumpWidget(TestMyApp(
        onTappedDay: (s, e) {
          capturedStart = s;
          capturedEnd = e;
        },
        setupData: setupData,
      ));

      // 開始日→終了日を設定
      await widgetTester.tap(find.text('10'));
      await widgetTester.pump();
      await widgetTester.tap(find.text('20'));
      await widgetTester.pump();

      // 開始日を再タップ
      await widgetTester.tap(find.text('10'));
      await widgetTester.pump();

      expect(capturedStart, isNull);
      expect(capturedEnd, isNull);
    });

    testWidgets('開始日より前の日付タップで開始日がリセットされる', (widgetTester) async {
      DateTime? capturedStart;
      DateTime? capturedEnd;

      await widgetTester.pumpWidget(TestMyApp(
        onTappedDay: (s, e) {
          capturedStart = s;
          capturedEnd = e;
        },
        setupData: setupData,
      ));

      await widgetTester.tap(find.text('15'));
      await widgetTester.pump();
      // 開始日より前をタップ
      await widgetTester.tap(find.text('5'));
      await widgetTester.pump();

      expect(capturedStart, DateTime(2023, 1, 5));
      expect(capturedEnd, isNull);
    });
  });

  group('ダブルマンスレイアウト：', () {
    testWidgets('2ヶ月分のタイトルが表示される', (widgetTester) async {
      final setupData = CalendarSetupData(
        initialMonth: DateTime(2023, 1),
      );

      await widgetTester.pumpWidget(MaterialApp(
        home: SafeArea(
          child: SingleChildScrollView(
            child: DateRangeCalendar(
              calendarType: CalendarType.doubleMonth,
              onTappedDay: (s, e) {},
              setupData: setupData,
            ),
          ),
        ),
      ));

      expect(find.text('January 2023'), findsOneWidget);
      expect(find.text('February 2023'), findsOneWidget);
    });
  });

  group('エッジケース：', () {
    testWidgets('2月は28日まで表示される（平年）', (widgetTester) async {
      final setupData = CalendarSetupData(
        initialMonth: DateTime(2023, 2),
      );

      await widgetTester.pumpWidget(TestMyApp(
        onTappedDay: (s, e) {},
        setupData: setupData,
      ));

      expect(find.text('28'), findsOneWidget);
      expect(find.text('29'), findsNothing);
    });

    testWidgets('2月は29日まで表示される（うるう年）', (widgetTester) async {
      final setupData = CalendarSetupData(
        initialMonth: DateTime(2024, 2),
      );

      await widgetTester.pumpWidget(TestMyApp(
        onTappedDay: (s, e) {},
        setupData: setupData,
      ));

      expect(find.text('29'), findsOneWidget);
      expect(find.text('30'), findsNothing);
    });

    testWidgets('年をまたぐ月送り（12月→1月）', (widgetTester) async {
      final setupData = CalendarSetupData(
        initialMonth: DateTime(2023, 12),
      );

      await widgetTester.pumpWidget(TestMyApp(
        onTappedDay: (s, e) {},
        setupData: setupData,
      ));

      expect(find.text('December 2023'), findsOneWidget);

      await widgetTester.tap(find.byIcon(Icons.keyboard_arrow_right));
      await widgetTester.pump();

      expect(find.text('January 2024'), findsOneWidget);
    });

    testWidgets('年をまたぐ月戻り（1月→12月）', (widgetTester) async {
      final setupData = CalendarSetupData(
        initialMonth: DateTime(2024, 1),
      );

      await widgetTester.pumpWidget(TestMyApp(
        onTappedDay: (s, e) {},
        setupData: setupData,
      ));

      expect(find.text('January 2024'), findsOneWidget);

      await widgetTester.tap(find.byIcon(Icons.keyboard_arrow_left));
      await widgetTester.pump();

      expect(find.text('December 2023'), findsOneWidget);
    });
  });
}

class TestMyApp extends StatelessWidget {
  const TestMyApp({
    required this.onTappedDay,
    this.setupData = const CalendarSetupData(),
    super.key,
  });

  final void Function(DateTime?, DateTime?) onTappedDay;
  final CalendarSetupData setupData;

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
