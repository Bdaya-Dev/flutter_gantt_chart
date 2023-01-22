import 'package:flutter/material.dart';
import 'package:gantt_chart/gantt_chart.dart';

class GanttChartDefaultStickyAreaCell extends StatelessWidget {
  final GanttEventBase event;
  final int eventIndex;
  final Color eventColor;
  final WidgetBuilder? widgetBuilder;

  const GanttChartDefaultStickyAreaCell({
    super.key,
    required this.event,
    required this.eventIndex,
    required this.eventColor,
    this.widgetBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: eventColor,
        border: BorderDirectional(
          top: eventIndex == 0 ? const BorderSide() : BorderSide.none,
          start: const BorderSide(),
          end: const BorderSide(),
          bottom: const BorderSide(),
        ),
      ),
      child: Center(
        child: widgetBuilder?.call(context) ?? _defaultChild(context),
      ),
    );
  }

  Widget _defaultChild(BuildContext context) => Text(
        event.getDisplayName(context),
      );
}
