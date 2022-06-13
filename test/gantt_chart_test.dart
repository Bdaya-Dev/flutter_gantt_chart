import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gantt_chart/gantt_chart.dart';

bool isHoliday(BuildContext context, DateTime date) {
  return false;
}

void main() {
  testWidgets('Test start is holiday', (tester) async {
    await tester.pumpWidget(Builder(
      builder: (context) {
        //
        final start = DateTime(2022, 06, 04);
        final weekends = {
          WeekDay.friday,
          WeekDay.saturday,
        };

        expect(
          getRelativeDateInclusiveStartExeclusiveEnd(
            context,
            start,
            const Duration(days: 0),
            weekends,
            isHoliday,
          ),
          start,
        );

        expect(
          getRelativeDateInclusiveStartExeclusiveEnd(
            context,
            start,
            const Duration(days: 1), //skip 1 workday
            weekends,
            isHoliday,
          ),
          //skips saturday because it's a holiday, and sunday (1 workday)
          DateUtils.addDaysToDate(start, 1 + 1),
        );

        expect(
          getRelativeDateInclusiveStartExeclusiveEnd(
            context,
            start,
            const Duration(days: 7), //skip 7 workdays
            weekends,
            isHoliday,
          ),
          //skips saturday because it's a holiday, and an entire week (5 days) then (friday and saturday) then 2 days
          DateUtils.addDaysToDate(start, 1 + 5 + 2 + 2),
        );
        //tests custom holiday
        expect(
          getRelativeDateInclusiveStartExeclusiveEnd(
            context,
            start,
            const Duration(days: 14),
            weekends,
            (context, date) => date.day == 15,
          ),
          DateUtils.addDaysToDate(
            start,
            1 /*Saturday*/ +
                5 /*5 work days*/ +
                2 /*Saturday and Friday*/ +
                3 /*3 work days*/ +
                1 /*1 holiday*/ +
                1 /*1 work day*/ +
                2 /*Saturday and Friday*/ +
                5 /*5 work days*/,
          ),
        );
        return const Placeholder();
      },
    ));
  });

  testWidgets('Test at middle of week', (tester) async {
    await tester.pumpWidget(Builder(
      builder: (context) {
        //
        final start = DateTime(2022, 06, 06);
        final weekends = {
          WeekDay.friday,
          WeekDay.saturday,
        };

        expect(
          getRelativeDateInclusiveStartExeclusiveEnd(
            context,
            start,
            const Duration(days: 0),
            weekends,
            isHoliday,
          ),
          start,
        );
        expect(
          getRelativeDateInclusiveStartExeclusiveEnd(
            context,
            start,
            const Duration(days: 1),
            weekends,
            isHoliday,
          ),
          DateUtils.addDaysToDate(start, 1),
        );
        expect(
          getRelativeDateInclusiveStartExeclusiveEnd(
            context,
            start,
            const Duration(days: 2),
            weekends,
            isHoliday,
          ),
          DateUtils.addDaysToDate(start, 2),
        );
        expect(
          getRelativeDateInclusiveStartExeclusiveEnd(
            context,
            start,
            const Duration(days: 3),
            weekends,
            isHoliday,
          ),
          DateUtils.addDaysToDate(start, 3),
        );
        expect(
          getRelativeDateInclusiveStartExeclusiveEnd(
            context,
            start,
            const Duration(days: 4),
            weekends,
            isHoliday,
          ),
          DateUtils.addDaysToDate(start, 4 /*4 work days*/),
        );
        expect(
          getRelativeDateInclusiveStartExeclusiveEnd(
            context,
            start,
            const Duration(days: 5),
            weekends,
            isHoliday,
          ),
          DateUtils.addDaysToDate(
            start,
            4 /*4 work days*/ + 2 /*Sat,Fri*/ + 1 /*1 work day*/,
          ),
        );
        return const Placeholder();
      },
    ));
  });
}
