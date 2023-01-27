import 'package:flutter_test/flutter_test.dart';
import 'package:gantt_chart/src/gantt_default_week_header.dart';

// Based on https://www.epochconverter.com/weeks/2023
void main() {
  test('week number edge cases', () {
    final widgetStartOfYear = GanttChartDefaultWeekHeader(
      weekDate: DateTime(2023, 1, 1, 0, 0, 0, 1),
    );

    final widgetWeek1 = GanttChartDefaultWeekHeader(
      weekDate: DateTime(2023, 1, 8, 0, 0, 0, 1),
    );

    final widgetMidOfYear = GanttChartDefaultWeekHeader(
      weekDate: DateTime(2023, 6, 2, 1, 1, 1), // 2nd of June 2023
    );

    final widgetEndOfYear = GanttChartDefaultWeekHeader(
      weekDate: DateTime(2022, 12, 31, 23, 59, 59),
    );

    expect(widgetStartOfYear.weekNumberWithinThisYear, 52); // of previous year
    expect(widgetWeek1.weekNumberWithinThisYear, 1);
    expect(widgetMidOfYear.weekNumberWithinThisYear, 22);
    expect(widgetEndOfYear.weekNumberWithinThisYear, 52);
  });
}
