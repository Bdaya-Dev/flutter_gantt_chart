import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'gantt_view.dart';
import 'week_day.dart';

//start + (d + holidays between (start) and (start + d))
DateTime getRelativeDate(
  BuildContext context,
  DateTime start,
  Duration d,
  Set<WeekDay> weekends,
  IsExtraHolidayFunc isExtraHolidayFunc,
) {
  var extraDurationDays = 0;
  var workDayIndex = 0;
  while (true) {
    if (workDayIndex == d.inDays) break;
    final dateToTest =
        start.add(Duration(days: workDayIndex + extraDurationDays));
    final weekday = WeekDay.fromIntWeekday(dateToTest.weekday);
    if (weekends.contains(weekday) || isExtraHolidayFunc(context, dateToTest)) {
      extraDurationDays++;
    } else {
      workDayIndex++;
    }
  }
  return start.add(Duration(days: workDayIndex + extraDurationDays - 1));
}

abstract class GanttEventBase {
  Object? get extra;
  String? get displayName;
  Color? get suggestedColor;
  String Function(BuildContext context)? get displayNameBuilder;

  DateTime getStartDate(
    BuildContext context,
    DateTime ganttStartDate,
    Set<WeekDay> weekends,
    IsExtraHolidayFunc isExtraHolidayFunc,
  );

  DateTime getEndDate(
    BuildContext context,
    DateTime calculatedStartDate,
    Set<WeekDay> weekends,
    IsExtraHolidayFunc isExtraHolidayFunc,
  );

  String getDisplayName(BuildContext context) =>
      displayName ?? displayNameBuilder?.call(context) ?? '';
}

class GanttAbsoluteEvent extends GanttEventBase {
  final DateTime startDate;
  final DateTime endDate;
  @override
  final String? displayName;
  @override
  final String Function(BuildContext context)? displayNameBuilder;
  @override
  final Object? extra;

  @override
  final Color? suggestedColor;
  GanttAbsoluteEvent({
    required this.startDate,
    required this.endDate,
    this.extra,
    this.displayNameBuilder,
    this.displayName,
    this.suggestedColor,
  });

  @override
  DateTime getEndDate(
    BuildContext context,
    DateTime calculatedStartDate,
    Set<WeekDay> weekends,
    IsExtraHolidayFunc isExtraHolidayFunc,
  ) {
    return endDate;
  }

  @override
  DateTime getStartDate(
    BuildContext context,
    DateTime ganttStartDate,
    Set<WeekDay> weekends,
    IsExtraHolidayFunc isExtraHolidayFunc,
  ) {
    return ganttStartDate.isAfter(startDate) ? ganttStartDate : startDate;
  }
}

class GanttRelativeEvent extends GanttEventBase {
  final Duration relativeToStart;
  final Duration duration;
  final String? id;
  @override
  final Object? extra;
  @override
  final String? displayName;
  @override
  final String Function(BuildContext context)? displayNameBuilder;

  @override
  final Color? suggestedColor;

  GanttRelativeEvent({
    required this.relativeToStart,
    required this.duration,
    this.id,
    this.extra,
    this.displayName,
    this.displayNameBuilder,
    this.suggestedColor,
  });

  @override
  DateTime getEndDate(
    BuildContext context,
    DateTime calculatedStartDate,
    Set<WeekDay> weekends,
    IsExtraHolidayFunc isExtraHolidayFunc,
  ) =>
      getRelativeDate(
        context,
        calculatedStartDate,
        duration,
        weekends,
        isExtraHolidayFunc,
      );

  @override
  DateTime getStartDate(
    BuildContext context,
    DateTime ganttStartDate,
    Set<WeekDay> weekends,
    IsExtraHolidayFunc isExtraHolidayFunc,
  ) =>
      getRelativeDate(
        context,
        ganttStartDate,
        relativeToStart,
        weekends,
        isExtraHolidayFunc,
      );
}
