class PickerDate {
  static DateTime dateTimeNow = DateTime.now();
  static DateTime today =
      DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day);
  // lấy ra tuần của ngày hiện tại.
  static final week = today.weekday;
  static DateTime dateSelect = today;

  // lấy ra ngày đầu tiên của tuần.
  static DateTime dayS = today.subtract(Duration(days: week - 1));

  static List<DateTime> days = [];

  static List<DateTime> weekStartEnd(int weekSelect) {
    int i = weekSelect - week;
    var daySelectS = dayS.add(Duration(days: i * 7));
    days = [daySelectS];
    for (int n = 1; n < 7; n++) days.add(daySelectS.add(Duration(days: n)));
    return days.toList();
  }
}
