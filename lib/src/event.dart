import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'gantt_view.dart';
import 'week_day.dart';

/// start + (d + holidays between (start) and (start + d))
/// note that this is execlusive for last date
DateTime getRelativeDate(
  BuildContext context,
  DateTime start,
  Duration d,
  Set<WeekDay> weekends,
  IsExtraHolidayFunc isExtraHolidayFunc,
) {
  if (d.inDays == 0) return start;
  final targetWorkDays = d.inDays;
  var index = 0;
  var workDaysCount = 0;
  while (workDaysCount < targetWorkDays) {
    final dayToTest = DateUtils.addDaysToDate(start, index);
    final weekday = WeekDay.fromIntWeekday(dayToTest.weekday);
    if (!weekends.contains(weekday) &&
        !isExtraHolidayFunc(context, dayToTest)) {
      workDaysCount++;
    }
    index++;
  }
  return DateUtils.addDaysToDate(start, index - 1);
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
        relativeToStart, //start date + relative + 1
        weekends,
        isExtraHolidayFunc,
      );
}
