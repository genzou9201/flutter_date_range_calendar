import 'package:date_range_calendar/src/core/util.dart';
import 'package:date_range_calendar/src/view/dates_outline.dart';
import 'package:flutter/material.dart';

class CalendarOutline extends StatefulWidget {
  const CalendarOutline({
    required this.onTappedDay,
    this.backgroundColor = Colors.white,
    Key? key,
  }) : super(key: key);

  final Color backgroundColor;
  final Function(DateTime?, DateTime?) onTappedDay;

  @override
  State<CalendarOutline> createState() => _CalendarOutlineState();
}

class _CalendarOutlineState extends State<CalendarOutline> {
  late DateTime baseDateTime;
  late DateTime? selectedStartDate;
  late DateTime? selectedEndDate;

  @override
  void initState() {
    final now = DateTime.now();
    baseDateTime = DateTime(now.year, now.month - 1);
    selectedStartDate = null;
    selectedEndDate = null;
    super.initState();
  }

  void setNewDates(DateTime tappedDate) {
    if (selectedStartDate != null &&
        selectedEndDate == null &&
        tappedDate.isAtSameMomentAs(selectedStartDate!)) {
      setState(() => selectedStartDate = null);
      return;
    }
    if (selectedStartDate == null) {
      setState(() => selectedStartDate = tappedDate);
      return;
    }
    if (tappedDate.isBefore(selectedStartDate!)) {
      setState(() => selectedStartDate = tappedDate);
      return;
    }
    if (selectedEndDate != null &&
        tappedDate.isAtSameMomentAs(selectedEndDate!)) {
      setState(() => selectedEndDate = null);
      return;
    }
    if (tappedDate.isAfter(selectedStartDate!)) {
      setState(() => selectedEndDate = tappedDate);
      return;
    }
  }

  void onTapDay(DateTime tappedDate) {
    setNewDates(tappedDate);
    widget.onTappedDay(selectedStartDate, selectedEndDate);
  }

  @override
  Widget build(BuildContext context) {
    final nextDateTime = DateTime(baseDateTime.year, baseDateTime.month + 1);

    return Material(
      elevation: 9,
      child: Container(
        width: 330,
        color: widget.backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Month Title
            ///
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: _buildPrevButton(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 18, bottom: 15),
                  child: Text(
                    '${getMonthString(baseDateTime)} ${baseDateTime.year}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),

            /// Dates Outline
            ///
            DatesOutline(
              year: baseDateTime.year,
              month: baseDateTime.month,
              selectedStartDate: selectedStartDate,
              selectedEndDate: selectedEndDate,
              onTapDay: onTapDay,
            ),

            Row(
              children: [
                Expanded(child: Container()),
                Container(
                  margin: const EdgeInsets.only(top: 18, bottom: 15),
                  child: Text(
                    '${getMonthString(nextDateTime)} ${nextDateTime.year}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: _buildNextButton(nextDateTime),
                  ),
                ),
              ],
            ),

            /// Dates Outline
            ///
            DatesOutline(
              year: (nextDateTime.year),
              month: (nextDateTime.month),
              selectedStartDate: selectedStartDate,
              selectedEndDate: selectedEndDate,
              onTapDay: onTapDay,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(DateTime nextDateTime) {
    return Material(
      child: InkWell(
        onTap: () {
          setState(() {
            baseDateTime = nextDateTime;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black38),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.black54,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildPrevButton() {
    return Material(
      child: InkWell(
        onTap: () {
          setState(() {
            final prevDateTime =
                DateTime(baseDateTime.year, baseDateTime.month - 1);
            baseDateTime = prevDateTime;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black38),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black54,
            size: 20,
          ),
        ),
      ),
    );
  }
}
