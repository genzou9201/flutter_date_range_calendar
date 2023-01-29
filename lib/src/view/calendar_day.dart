import 'package:date_range_calendar/src/data/calendar_setup_data.dart';
import 'package:flutter/material.dart';

abstract class CalendarDay extends StatelessWidget {
  const CalendarDay({super.key});

  static const double height = 33;
  static const double width = 40;

  static void noCallback(DateTime _) {}
}

/// This is the StatelessWidget that render the no day such as
/// a first Monday cell in first week if its month starts Friday
/// as 1st day.
///
class CalendarDayEmpty extends CalendarDay {
  const CalendarDayEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: CalendarDay.height, width: CalendarDay.width);
  }
}

/// This is the StatelessWidget that render the day of the month.
///
class CalendarDayExist extends CalendarDay {
  const CalendarDayExist({
    required this.date,
    required this.isEndDay,
    required this.isMiddleDay,
    required this.isStartDay,
    required this.isSelectedOnlyStartDay,
    required this.isToday,
    required this.setupData,
    this.onTap = CalendarDay.noCallback,
    Key? key,
  }) : super(key: key);

  final DateTime date;
  final bool isEndDay;
  final bool isMiddleDay;
  final bool isStartDay;
  final bool isSelectedOnlyStartDay;
  final bool isToday;
  final Function(DateTime) onTap;
  final CalendarSetupData setupData;

  @override
  Widget build(BuildContext context) {
    final style = setupData.dayCellStyle;
    var color = Colors.transparent;

    // Setting of background color.
    if (isMiddleDay) color = style.backgroundColorOfBetweenDay;
    if (isStartDay) color = style.backgroundColorOfStartDay;
    if (isEndDay) color = style.backgroundColorOfEndDay;

    // Setting of radius.
    var leftRadius = const Radius.circular(0);
    var rightRadius = const Radius.circular(0);
    if (date.weekday == 1) leftRadius = style.borderRadius;
    if (date.weekday == 7) rightRadius = style.borderRadius;
    if (isStartDay) leftRadius = style.borderRadius;
    if (isEndDay) rightRadius = style.borderRadius;
    if (isSelectedOnlyStartDay) rightRadius = style.borderRadius;

    // Get boolean if a day is today and unselected.
    final isUnselectedToday =
        isToday && !isStartDay && !isMiddleDay && !isEndDay;
    if (isUnselectedToday) leftRadius = style.borderRadius;
    if (isUnselectedToday) rightRadius = style.borderRadius;

    return Container(
      decoration: BoxDecoration(
        color: color,
        border: isUnselectedToday
            ? Border.all(color: style.borderColorOfToday, width: 1)
            : null,
        borderRadius: BorderRadius.horizontal(
          left: leftRadius,
          right: rightRadius,
        ),
      ),
      height: CalendarDay.height,
      width: CalendarDay.width,
      child: GestureDetector(
        onTap: () => onTap(date),
        child: Container(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              date.day.toString(),
              style: TextStyle(
                color: (isEndDay || isStartDay) ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
