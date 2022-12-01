import 'package:flutter/material.dart';
import 'package:date_range_calendar/src/view/calendar_day.dart';

class DatesInMonth extends StatelessWidget {
  const DatesInMonth({
    required this.targetYear,
    required this.targetMonth,
    required this.selectedStartDate,
    required this.selectedEndDate,
    required this.onTapDay,
    Key? key,
  }) : super(key: key);

  final int targetYear;
  final int targetMonth;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final Function(DateTime) onTapDay;

  @override
  Widget build(BuildContext context) {
    final targetDate = DateTime(targetYear, targetMonth);
    var tempDate = targetDate;

    /// 1日が曜日とマッチした時点から始まるようにするために使用する変数
    var isStartedIncrementDate = false;

    /// 最終アウトプットのウィジェットリスト
    var result = <Widget>[];

    /// 7日×6週分の処理
    const maxWeeks = 6;
    const daysCountInWeek = 7;
    var weekWidget = <CalendarDay>[];
    for (var week = 0; week < maxWeeks; week++) {
      for (var dayCount = 0; dayCount < daysCountInWeek; dayCount++) {
        /// ①: 1週目の1日の曜日を計算する。
        if (week == 0 && tempDate.weekday == (dayCount + 1)) {
          isStartedIncrementDate = true;
        }

        /// ②: [tempDate]を1日ずつ進めて該当月の月末までの間は処理を実行する。
        if (isStartedIncrementDate && tempDate.month == targetMonth) {
          var isMiddleDay = false;
          if (selectedStartDate != null && selectedEndDate != null) {
            isMiddleDay = selectedStartDate!.isBefore(tempDate) &&
                selectedEndDate!.isAfter(tempDate);
          }
          final isSelectedOnlyStartDay =
              tempDate == selectedStartDate && selectedEndDate == null;

          weekWidget.add(
            CalendarDayExist(
              date: tempDate,
              isStartDay: tempDate == selectedStartDate,
              isMiddleDay: isMiddleDay,
              isEndDay: tempDate == selectedEndDate,
              isSelectedOnlyStartDay: isSelectedOnlyStartDay,
              onTap: onTapDay,
            ),
          );
        } else {
          weekWidget.add(const CalendarDayEmpty());
        }

        /// ③: ①の条件を満たした後は常に実行。[tempDate]を1日進める。
        if (isStartedIncrementDate) {
          tempDate = tempDate.add(const Duration(days: 1));
        }
      }

      /// 1週間分ごとに結果を溜めていく。
      final hasDate = weekWidget.any((e) => e.runtimeType == CalendarDayExist);
      if (hasDate) {
        result.addAll([
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [...weekWidget],
          ),
          const Divider(indent: 9, endIndent: 9, height: 9),
        ]);
      }
      weekWidget.clear();
    }

    /// 最後の[Divider]を削除
    if (result.isNotEmpty) result.removeLast();
    return Column(children: result);
  }
}
