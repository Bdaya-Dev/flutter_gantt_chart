
[![pub package](https://img.shields.io/pub/v/gantt_chart)](https://pub.dev/packages/gantt_chart)

[![Github](https://img.shields.io/github/last-commit/Bdaya-Dev/flutter_gantt_chart)](https://github.com/Bdaya-Dev/flutter_gantt_chart)


A fully customizable [gantt chart](https://www.gantt.com) package written purely in dart

> This package is still in active development and may experience breaking changes

## Features

<img src="https://github.com/Bdaya-Dev/flutter_gantt_chart/blob/master/doc/demo.png?raw=true"/>

* Sticky area to show event names
* Fully customizable widget with builders
* Either use relative or absolute dates

## Usage


```dart
GanttChartView(
    maxDuration: const Duration(days: 30 * 2), //optional, set to null for infinite horizontal scroll
    startDate: DateTime(2022, 6, 7), //required 
    dayWidth: 30, //column width for each day
    eventHeight: 30, //row height for events
    stickyAreaWidth: 200, //sticky area width
    showStickyArea: true, //show sticky area or not
    showDays: true, //show days or not
    startOfTheWeek: WeekDay.sunday, //custom start of the week
    weekEnds: const {WeekDay.friday, WeekDay.saturday}, //custom weekends
    isExtraHoliday: (context, day) {
        //define custom holiday logic for each day
        return DateUtils.isSameDay(DateTime(2022, 7, 1), day);
    },
    events: [
        //event relative to startDate
        GanttRelativeEvent(
            relativeToStart: const Duration(days: 0),
            duration: const Duration(days: 5),
            displayName: 'Do a very helpful task',
        ),
        //event with absolute start and end
        GanttAbsoluteEvent(
            startDate: DateTime(2022, 6, 10),
            endDate: DateTime(2022, 6, 16),
            displayName: 'Another task',
        ),
    ],
),
```
