import 'package:flutter/material.dart';

class GanttChartDefaultWeekHeader extends StatelessWidget {
  const GanttChartDefaultWeekHeader({
    Key? key,
    required this.weekDate,
  }) : super(key: key);
  final DateTime weekDate;

  int get weekNumberWithinThisYear {
    final numberWeek = (DateTime.utc(
                    weekDate.year, weekDate.month, weekDate.day)
                .difference(DateTime.utc(weekDate.year, 1, 1, 0, 0, 0, 0, 0))
                .inDays /
            7)
        .ceil();

    return numberWeek == 0 ? 1 : numberWeek;
  }

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
                '${weekDate.day}-${weekDate.month}-${weekDate.year}  #$weekNumberWithinThisYear';
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
