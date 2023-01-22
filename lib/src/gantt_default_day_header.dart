import 'package:flutter/material.dart';

import 'week_day.dart';

class GanttChartDefaultDayHeader extends StatelessWidget {
  final Color? color;
  final Color? backgroundColor;
  final BoxBorder? border;

  const GanttChartDefaultDayHeader({
    Key? key,
    required this.date,
    required this.isHoliday,
    this.color,
    this.backgroundColor,
    this.border,
  }) : super(key: key);

  final DateTime date;
  final bool isHoliday;

  @override
  Widget build(BuildContext context) {
    final weekDay = WeekDay.fromIntWeekday(date.weekday);
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? defaultBackgroundColor(isHoliday),
        border: border ?? defaultBorder,
      ),
      child: Center(
        child: Text(
          weekDay.symbol,
          style: TextStyle(color: color ?? defaultColor(isHoliday)),
        ),
      ),
    );
  }

  Color defaultColor(bool isHoliday) => isHoliday ? Colors.white : Colors.black;

  Color defaultBackgroundColor(bool isHoliday) =>
      isHoliday ? Colors.grey.shade800 : Colors.white;

  BoxBorder get defaultBorder => const BorderDirectional(
        bottom: BorderSide(),
        start: BorderSide(),
      );
}
