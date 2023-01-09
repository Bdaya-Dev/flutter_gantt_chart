import 'package:flutter/material.dart';

// TODO extend display with week number
extension WeeksBetween on DateTime {
  int get weekNumberOfTheYear => (DateTime.utc(year, month, day)
              .difference(DateTime.utc(year, 1, 1))
              .inDays /
          7)
      .ceil();
}

class GanttChartDefaultWeekHeader extends StatelessWidget {
  const GanttChartDefaultWeekHeader({
    Key? key,
    required this.weekDate,
  }) : super(key: key);
  final DateTime weekDate;

  @override
  Widget build(BuildContext context) {
    final bgColor = Colors.blue.shade900;
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 8, top: 1, bottom: 1),
      decoration: BoxDecoration(
        color: bgColor,
        border: const BorderDirectional(
          start: BorderSide(),
          bottom: BorderSide(),
        ),
      ),
      child: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          String txt;
          if (constraints.maxWidth < 50) {
            txt = weekDate.month.toString();
          } else if (constraints.maxWidth < 7 * 20) {
            txt = '${weekDate.month}-${weekDate.year % 100}';
          } else {
            txt =
                '${weekDate.day}-${weekDate.month}-${weekDate.year}  #${weekDate.weekNumberOfTheYear} ';
          }

          return Text(
            txt,
            style: const TextStyle(color: Colors.white),
          );
        }),
      ),
    );
  }
}
