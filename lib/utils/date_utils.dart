import 'package:grin_plus_plus/strings.dart';
import 'package:intl/intl.dart';

String getSmartDateString(DateTime date, {bool withTime = false}) {
  String dateString;

  DateTime now = DateTime.now();
  if (isSameDay(date, now)) {
    dateString = kTodayString.toLowerCase();
  } else if (date.year == now.year && date.month == now.month) {
    int diffInDays = date.day - now.day;
    if (diffInDays == 1) {
      dateString = kTomorrowString.toLowerCase();
    } else if (diffInDays == -1) {
      dateString = kYesterdayString.toLowerCase();
    } else if (diffInDays >= 2 && diffInDays < 7) {
      dateString = kThisWeekdayStrings[date.weekday - 1];
    } else {
      dateString = DateFormat('d MMMM yyyy').format(date).toLowerCase();
    }
  } else {
    dateString = DateFormat('d MMMM yyyy').format(date).toLowerCase();
  }

  if (withTime) {
    dateString += ' at ${DateFormat.Hm().format(date)}';
  }
  return dateString;
}

bool isSameDay(DateTime date, DateTime anotherDate) =>
    date.year == anotherDate.year && date.month == anotherDate.month && date.day == anotherDate.day;