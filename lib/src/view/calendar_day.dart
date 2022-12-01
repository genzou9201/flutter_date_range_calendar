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
    this.onTap = CalendarDay.noCallback,
    Key? key,
  }) : super(key: key);

  final DateTime date;
  final bool isEndDay;
  final bool isMiddleDay;
  final bool isStartDay;
  final bool isSelectedOnlyStartDay;
  final Function(DateTime) onTap;

  @override
  Widget build(BuildContext context) {
    var color = Colors.transparent;
    if (isMiddleDay) color = const Color(0xFFF7E6F6);
    if (isEndDay || isStartDay) color = const Color(0xFFB769B6);

    var leftRadius = const Radius.circular(0);
    var rightRadius = const Radius.circular(0);
    if (date.weekday == 1) leftRadius = const Radius.circular(9);
    if (date.weekday == 7) rightRadius = const Radius.circular(9);
    if (isStartDay) leftRadius = const Radius.circular(9);
    if (isEndDay) rightRadius = const Radius.circular(9);
    if (isSelectedOnlyStartDay) rightRadius = const Radius.circular(9);

    return Container(
      decoration: BoxDecoration(
        color: color,
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
