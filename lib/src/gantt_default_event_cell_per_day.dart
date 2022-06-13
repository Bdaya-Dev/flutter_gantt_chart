import 'package:flutter/material.dart';
import 'event.dart';

class GanttChartDefaultEventRowPerDayBuilder extends StatelessWidget {
  const GanttChartDefaultEventRowPerDayBuilder({
    Key? key,
    required this.dayDate,
    required this.isHoliday,
    required this.event,
    required this.actStartDate,
    required this.actEndDate,
    required this.weekDate,
    required this.holidayColor,
    required this.eventColor,
  }) : super(key: key);
  final Color eventColor;
  final DateTime dayDate;
  final bool isHoliday;
  final GanttEventBase event;
  final DateTime actStartDate;
  final DateTime actEndDate;
  final DateTime weekDate;

  final Color? holidayColor;

  @override
  Widget build(BuildContext context) {
    final isWithinEvent = !DateUtils.isSameDay(actStartDate, actEndDate) &&
        (DateUtils.isSameDay(actStartDate, dayDate) ||
            dayDate.isAfter(actStartDate) && dayDate.isBefore(actEndDate));

    final color = isHoliday
        ? (holidayColor ?? Colors.grey)
        : isWithinEvent
            ? eventColor
            : null;
    return Container(
      decoration: BoxDecoration(
        color: isHoliday ? color : null,
        border: const BorderDirectional(
          top: BorderSide.none,
          bottom: BorderSide.none,
          start: BorderSide(),
        ),
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
