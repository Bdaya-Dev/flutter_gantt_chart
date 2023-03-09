import 'package:flutter/material.dart';
import 'event.dart';

class GanttChartDefaultEventRowPerDayBuilder extends StatelessWidget {
  static const defaultHolidayColor = Colors.grey;
  static const defaultBorder = BorderDirectional(
    top: BorderSide.none,
    bottom: BorderSide.none,
    start: BorderSide(),
  );

  const GanttChartDefaultEventRowPerDayBuilder({
    super.key,
    required this.dayDate,
    required this.isHoliday,
    required this.event,
    required this.actStartDate,
    required this.actEndDate,
    required this.weekDate,
    required this.eventColor,
    this.holidayColor,
    this.border,
  });

  final Color eventColor;
  final DateTime dayDate;
  final bool isHoliday;
  final GanttEventBase event;
  final DateTime actStartDate;
  final DateTime actEndDate;
  final DateTime weekDate;

  final Color? holidayColor;
  final BoxBorder? border;
  @override
  Widget build(BuildContext context) {
    final isWithinEvent = !DateUtils.isSameDay(actStartDate, actEndDate) &&
        (DateUtils.isSameDay(actStartDate, dayDate) ||
            dayDate.isAfter(actStartDate) && dayDate.isBefore(actEndDate));

    final color = isHoliday
        ? (holidayColor ?? defaultHolidayColor)
        : isWithinEvent
            ? eventColor
            : null;
    return Container(
      decoration: BoxDecoration(
        color: isHoliday ? color : null,
        border: border ?? defaultBorder,
      ),
      child: !isWithinEvent || isHoliday
          ? null
          : LayoutBuilder(
              builder: (context, constraints) => Center(
                child: Container(
                  height: constraints.maxHeight / 2,
                  color: color,
                ),
              ),
            ),
    );
  }
}
