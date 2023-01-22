import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gantt_chart/gantt_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double dayWidth = 30;
  bool showDaysRow = true;
  bool showStickyArea = true;
  bool customStickyArea = false;
  bool customWeekHeader = false;
  bool customDayHeader = false;

  void onZoomIn() {
    setState(() {
      dayWidth += 5;
    });
  }

  void onZoomOut() {
    if (dayWidth <= 10) return;
    setState(() {
      dayWidth -= 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gantt chart demo'),
        actions: [
          IconButton(
            onPressed: onZoomIn,
            icon: const Icon(
              Icons.zoom_in,
            ),
          ),
          IconButton(
            onPressed: onZoomOut,
            icon: const Icon(
              Icons.zoom_out,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SwitchListTile.adaptive(
              value: showDaysRow,
              title: const Text('Show Days Row ?'),
              onChanged: (v) => setState(() => showDaysRow = v),
            ),
            SwitchListTile.adaptive(
              value: showStickyArea,
              title: const Text('Show Sticky Area ?'),
              onChanged: (v) => setState(() => showStickyArea = v),
            ),
            SwitchListTile.adaptive(
              value: customStickyArea,
              title: const Text('Custom Sticky Area ?'),
              onChanged: (v) => setState(() => customStickyArea = v),
            ),
            SwitchListTile.adaptive(
              value: customWeekHeader,
              title: const Text('Custom Week Header ?'),
              onChanged: (v) => setState(() => customWeekHeader = v),
            ),
            SwitchListTile.adaptive(
              value: customDayHeader,
              title: const Text('Custom Day Header ?'),
              onChanged: (v) => setState(() => customDayHeader = v),
            ),
            GanttChartView(
              maxDuration: const Duration(days: 30 * 2),
              startDate: DateTime(2022, 6, 7),
              dayWidth: dayWidth,
              eventHeight: 40,
              stickyAreaWidth: 200,
              showStickyArea: showStickyArea,
              stickyAreaEventBuilder: customStickyArea
                  ? (context, eventIndex, event, eventColor) => eventIndex == 0
                      ? Container(
                          color: Colors.yellow,
                          child: Center(
                            child: Text("Custom Widget: ${event.displayName}"),
                          ),
                        )
                      : GanttChartDefaultStickyAreaCell(
                          event: event,
                          eventIndex: eventIndex,
                          eventColor: eventColor,
                          widgetBuilder: (context) => Text(
                            "Default Widget with custom colors: ${event.displayName}",
                            textAlign: TextAlign.center,
                          ),
                        )
                  : null,
              weekHeaderBuilder: customWeekHeader
                  ? (context, weekDate) => GanttChartDefaultWeekHeader(
                      weekDate: weekDate,
                      color: Colors.black,
                      backgroundColor: Colors.yellow,
                      border: const BorderDirectional(
                        end: BorderSide(color: Colors.green),
                      ))
                  : null,
              dayHeaderBuilder: customDayHeader
                  ? (context, date, bool isHoliday) =>
                      GanttChartDefaultDayHeader(
                        date: date,
                        isHoliday: isHoliday,
                        color: isHoliday ? Colors.yellow : Colors.black,
                        backgroundColor:
                            isHoliday ? Colors.grey : Colors.yellow,
                      )
                  : null,
              showDays: showDaysRow,
              weekEnds: const {WeekDay.friday, WeekDay.saturday},
              isExtraHoliday: (context, day) {
                //define custom holiday logic for each day
                return DateUtils.isSameDay(DateTime(2022, 7, 1), day);
              },
              startOfTheWeek: WeekDay.sunday,
              events: [
                GanttRelativeEvent(
                  relativeToStart: const Duration(days: 0),
                  duration: const Duration(days: 0),
                  displayName: 'Fake Event',
                ),
                GanttRelativeEvent(
                  relativeToStart: const Duration(days: 0),
                  duration: const Duration(days: 5),
                  displayName: '1) This is a very long event name',
                ),
                GanttRelativeEvent(
                  relativeToStart: const Duration(days: 1),
                  duration: const Duration(days: 6),
                  displayName: '2',
                ),
                GanttRelativeEvent(
                  relativeToStart: const Duration(days: 2),
                  duration: const Duration(days: 7),
                  displayName: '3',
                ),
                GanttRelativeEvent(
                  relativeToStart: const Duration(days: 3),
                  duration: const Duration(days: 8),
                  displayName: '4',
                ),
                GanttRelativeEvent(
                  relativeToStart: const Duration(days: 4),
                  duration: const Duration(days: 9),
                  displayName: '5',
                ),
                GanttRelativeEvent(
                  relativeToStart: const Duration(days: 5),
                  duration: const Duration(days: 10),
                  displayName: '6',
                ),
                GanttRelativeEvent(
                  relativeToStart: const Duration(days: 6),
                  duration: const Duration(days: 11),
                  displayName: '7',
                ),
                GanttRelativeEvent(
                  relativeToStart: const Duration(days: 7),
                  duration: const Duration(days: 12),
                  displayName: '8',
                ),
                GanttAbsoluteEvent(
                  displayName: 'Absoulte Date event',
                  startDate: DateTime(2022, 6, 7),
                  endDate: DateTime(2022, 6, 20),
                )
              ],
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: onZoomIn,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
