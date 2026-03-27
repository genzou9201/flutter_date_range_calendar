import 'package:date_range_calendar/src/data/calendar_setup_data.dart';
import 'package:date_range_calendar/src/data/types.dart';
import 'package:date_range_calendar/src/view/dates_outline.dart';
import 'package:date_range_calendar/src/view/month_title.dart';
import 'package:flutter/material.dart';

const double _kCalendarWidth = 330;
const double _kElevation = 9;
const double _kNavButtonSize = 36;
const double _kNavIconSize = 20;
const double _kNavButtonBorderRadius = 4;

class CalendarOutline extends StatefulWidget {
  const CalendarOutline({
    required this.onTappedDay,
    required this.calendarType,
    required this.setupData,
    this.backgroundColor,
    super.key,
  });

  final Color? backgroundColor;
  final CalendarType calendarType;
  final void Function(DateTime?, DateTime?) onTappedDay;
  final CalendarSetupData setupData;

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
    if (widget.setupData.initialMonth == null) {
      baseDateTime = DateTime(now.year, now.month);
    } else {
      baseDateTime = widget.setupData.initialMonth!;
    }
    selectedStartDate = null;
    selectedEndDate = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bgColor = widget.backgroundColor ?? colorScheme.surface;
    final nextDateTime = DateTime(baseDateTime.year, baseDateTime.month + 1);

    if (widget.calendarType == CalendarType.singleMonth) {
      return Material(
        elevation: _kElevation,
        child: Container(
          width: _kCalendarWidth,
          color: bgColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Month Title
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: _buildPrevButton(colorScheme),
                    ),
                  ),
                  MonthTitle(
                    setupData: widget.setupData,
                    baseDate: baseDateTime,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: _buildNextButton(nextDateTime, colorScheme),
                    ),
                  ),
                ],
              ),

              /// Dates Outline
              DatesOutline(
                year: baseDateTime.year,
                month: baseDateTime.month,
                selectedStartDate: selectedStartDate,
                selectedEndDate: selectedEndDate,
                onTapDay: onTapDay,
                setupData: widget.setupData,
              ),
            ],
          ),
        ),
      );
    }

    if (widget.calendarType == CalendarType.doubleMonth) {
      return Material(
        elevation: _kElevation,
        child: Container(
          width: _kCalendarWidth,
          color: bgColor,
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
                      child: _buildPrevButton(colorScheme),
                    ),
                  ),
                  MonthTitle(
                    setupData: widget.setupData,
                    baseDate: baseDateTime,
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
                setupData: widget.setupData,
              ),

              Row(
                children: [
                  Expanded(child: Container()),
                  MonthTitle(
                    setupData: widget.setupData,
                    baseDate: nextDateTime,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: _buildNextButton(nextDateTime, colorScheme),
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
                setupData: widget.setupData,
              ),
            ],
          ),
        ),
      );
    }

    return Container();
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

  Widget _buildNextButton(DateTime nextDateTime, ColorScheme colorScheme) {
    return Semantics(
      label: 'Next month',
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              baseDateTime = nextDateTime;
            });
          },
          borderRadius: BorderRadius.circular(_kNavButtonBorderRadius),
          child: SizedBox(
            width: _kNavButtonSize,
            height: _kNavButtonSize,
            child: Icon(
              Icons.keyboard_arrow_right,
              color: colorScheme.onSurface,
              size: _kNavIconSize,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrevButton(ColorScheme colorScheme) {
    return Semantics(
      label: 'Previous month',
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              final prevDateTime =
                  DateTime(baseDateTime.year, baseDateTime.month - 1);
              baseDateTime = prevDateTime;
            });
          },
          borderRadius: BorderRadius.circular(_kNavButtonBorderRadius),
          child: SizedBox(
            width: _kNavButtonSize,
            height: _kNavButtonSize,
            child: Icon(
              Icons.keyboard_arrow_left,
              color: colorScheme.onSurface,
              size: _kNavIconSize,
            ),
          ),
        ),
      ),
    );
  }
}
