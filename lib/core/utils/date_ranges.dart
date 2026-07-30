class DateRange {
  final DateTime inicio;
  final DateTime fin;
  const DateRange(this.inicio, this.fin);

  static DateRange today() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    return DateRange(start, start.add(const Duration(days: 1)));
  }

  static DateRange thisWeek() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));
    return DateRange(start, start.add(const Duration(days: 7)));
  }

  static DateRange lastNDays(int n) {
    final now = DateTime.now();
    final end = DateTime(now.year, now.month, now.day).add(const Duration(days: 1));
    return DateRange(end.subtract(Duration(days: n)), end);
  }
}
