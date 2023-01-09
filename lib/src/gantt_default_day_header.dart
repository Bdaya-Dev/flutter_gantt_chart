import 'package:flutter/material.dart';

import 'week_day.dart';

class GanttChartDefaultDayHeader extends StatelessWidget {
  const GanttChartDefaultDayHeader({
    Key? key,
    required this.date,
    required this.isHoliday,
  }) : super(key: key);

  final DateTime date;
  final bool Function(BuildContext context, DateTime date) isHoliday;

  @override
  Widget build(BuildContext context) {
    final weekDay = WeekDay.fromIntWeekday(date.weekday);
    final isHolidayV = isHoliday.call(context, date);
    final bgColor = isHolidayV ? Colors.grey.shade800 : Colors.white;
    final textColor = isHolidayV ? Colors.white : Colors.black;
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: const BorderDirectional(
          bottom: BorderSide(),
          // end: BorderSide(),
          start: BorderSide(),
        ),
      ),
      child: Center(
        child: Text(
          '${weekDay.symbol}\n${date.day}',
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
