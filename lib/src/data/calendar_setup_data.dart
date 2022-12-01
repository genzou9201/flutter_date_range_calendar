import 'package:flutter/material.dart';

/// Top level setup data
///
class CalendarSetupData {

}

/// CalendarOutline style
///
class CalendarOutlineStyle {
  const CalendarOutlineStyle({
    required this.backgroundColor,
    required this.elevation,
    required this.margin,
    required this.padding,
    required this.width,
  });

  final Color backgroundColor;
  final double elevation;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double width;
}