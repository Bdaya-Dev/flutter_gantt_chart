import 'package:flutter/material.dart';

import 'week_day.dart';

class GanttChartDefaultDayHeader extends StatelessWidget {
  static const defaultColor = Colors.black;
  static const defaultBackgroundColor = Colors.white;
  static const defaultHolidayColor = Colors.white;
  static final defaultHolidayBackgroundColor = Colors.grey.shade800;

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
        color: backgroundColor ?? _defaultBackgroundColor(isHoliday),
        border: border ?? _defaultBorder,
      ),
      child: widgetBuilder?.call(context) ?? _defaultChild(context),
    );
  }

  Color _defaultColor(bool isHoliday) =>
      isHoliday ? defaultHolidayColor : defaultColor;

  Color _defaultBackgroundColor(bool isHoliday) =>
      isHoliday ? defaultHolidayBackgroundColor : defaultBackgroundColor;

  BoxBorder get _defaultBorder => const BorderDirectional(
        bottom: BorderSide(),
        start: BorderSide(),
      );

  Widget _defaultChild(BuildContext context) => Center(
        child: Text(
          WeekDay.fromIntWeekday(date.weekday).symbol,
          style: TextStyle(color: color ?? _defaultColor(isHoliday)),
        ),
      );
}
