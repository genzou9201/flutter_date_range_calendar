import 'package:flutter/material.dart';
import 'package:date_range_calendar/src/view/dates_in_month.dart';
import 'package:date_range_calendar/src/view/day_of_the_week.dart';

class DatesOutline extends StatelessWidget {
  const DatesOutline({
    required this.year,
    required this.month,
    required this.selectedStartDate,
    required this.selectedEndDate,
    required this.onTapDay,
    Key? key,
  }) : super(key: key);

  final int year;
  final int month;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final Function(DateTime) onTapDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              DayOfTheWeek(label: 'Mon'),
              DayOfTheWeek(label: 'Tue'),
              DayOfTheWeek(label: 'Wed'),
              DayOfTheWeek(label: 'Thu'),
              DayOfTheWeek(label: 'Fri'),
              DayOfTheWeek(label: 'Sat'),
              DayOfTheWeek(label: 'Sun'),
            ],
          ),
          const Divider(indent: 9, endIndent: 9, height: 9),

          DatesInMonth(
            targetYear: year,
            targetMonth: month,
            selectedStartDate: selectedStartDate,
            selectedEndDate: selectedEndDate,
            onTapDay: onTapDay,
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
