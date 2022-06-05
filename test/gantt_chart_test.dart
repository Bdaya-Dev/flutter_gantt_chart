import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gantt_chart/gantt_chart.dart';

bool isHoliday(BuildContext context, DateTime date) {
  return false;
}

void main() {
  testWidgets('Main Test', (tester) async {
    await tester.pumpWidget(Builder(
      builder: (context) {
        //
        final start = DateTime(2022, 06, 04);
        final weekends = {
          WeekDay.friday,
          WeekDay.saturday,
        };

        expect(
          getRelativeDate(
            context,
            start,
            const Duration(days: 1),
            weekends,
            isHoliday,
          ),
          DateTime(2022, 06, 05),
        );

        expect(
          getRelativeDate(
            context,
            start,
            const Duration(days: 7),
            weekends,
            isHoliday,
          ),
          DateTime(2022, 06, 13),
        );
        expect(
          getRelativeDate(
            context,
            start,
            const Duration(days: 14),
            weekends,
            (context, date) => date.day == 15,
          ),
          DateTime(2022, 06, 23),
        );
        return const Placeholder();
      },
    ));
  });
}
