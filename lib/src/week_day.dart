enum WeekDay {
  monday(DateTime.monday, 'M'),
  tuesday(DateTime.tuesday, 'Tu'),
  wednesday(DateTime.wednesday, 'W'),
  thursday(DateTime.thursday, 'Th'),
  friday(DateTime.friday, 'F'),
  saturday(DateTime.saturday, 'Sa'),
  sunday(DateTime.sunday, 'Su');

  factory WeekDay.fromIntWeekday(int weekDay) {
    return WeekDay.values[weekDay - 1];
  }
  factory WeekDay.fromDateTime(DateTime day) {
    return WeekDay.values[day.weekday - 1];
  }

  final int number;
  final String symbol;
  const WeekDay(this.number, this.symbol);

  @override
  String toString() => '$name ($number)';
}
