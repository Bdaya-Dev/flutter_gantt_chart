import 'package:flutter/material.dart';

import 'week_day.dart';

class GanttChartDefaultDayHeader extends StatelessWidget {
  final Color? color;
  final Color? backgroundColor;
  final BoxBorder? border;
  final WidgetBuilder? widgetBuilder;

  const GanttChartDefaultDayHeader({
    Key? key,
    required this.date,
    required this.isHoliday,
    this.color,
    this.backgroundColor,
    this.border,
    this.widgetBuilder,
  }) : super(key: key);

  final DateTime date;
  final bool isHoliday;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? defaultBackgroundColor(isHoliday),
        border: border ?? defaultBorder,
      ),
      child: widgetBuilder?.call(context) ?? defaultChild(context),
    );
  }

  Color defaultColor(bool isHoliday) => isHoliday ? Colors.white : Colors.black;

  Color defaultBackgroundColor(bool isHoliday) =>
      isHoliday ? Colors.grey.shade800 : Colors.white;

  BoxBorder get defaultBorder => const BorderDirectional(
        bottom: BorderSide(),
        start: BorderSide(),
      );

  Widget defaultChild(BuildContext context) => Center(
        child: Text(
          WeekDay.fromIntWeekday(date.weekday).symbol,
          style: TextStyle(color: color ?? defaultColor(isHoliday)),
        ),
      );
}
