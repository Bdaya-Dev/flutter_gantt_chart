import 'package:flutter/material.dart';

class GanttChartDefaultWeekHeader extends StatelessWidget {
  final Color? color;
  final Color? backgroundColor;
  final BoxBorder? border;
  final WidgetBuilder? widgetBuilder;

  const GanttChartDefaultWeekHeader({
    Key? key,
    required this.weekDate,
    this.color,
    this.backgroundColor,
    this.border,
    this.widgetBuilder,
  }) : super(key: key);
  final DateTime weekDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 8, top: 1, bottom: 1),
      decoration: BoxDecoration(
        color: backgroundColor ?? defaultBackgroundColor,
        border: border ?? defaultBorder,
      ),
      child: widgetBuilder?.call(context) ?? defaultChild(context),
    );
  }

  Color get defaultColor => Colors.white;

  Color get defaultBackgroundColor => Colors.blue.shade900;

  BoxBorder get defaultBorder => const BorderDirectional(
        start: BorderSide(),
        bottom: BorderSide(),
      );

  Widget defaultChild(BuildContext context) =>
      Center(child: LayoutBuilder(builder: (context, constraints) {
        String txt;
        if (constraints.maxWidth < 50) {
          txt = weekDate.month.toString();
        } else if (constraints.maxWidth < 7 * 20) {
          txt = '${weekDate.month}-${weekDate.year % 100}';
        } else {
          txt = '${weekDate.day}-${weekDate.month}-${weekDate.year}';
        }

        return Text(
          txt,
          style: TextStyle(color: color ?? defaultColor),
        );
      }));
}
