import 'package:flutter/material.dart';

class DayOfTheWeek extends StatelessWidget {
  const DayOfTheWeek({required this.label, Key? key}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 40, maxWidth: 90),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
