import 'package:grin_plus_plus/strings.dart';
import 'package:intl/intl.dart';

String getSmartDateString(DateTime date) {
  String dateString;

  DateTime now = DateTime.now();
  if (isSameDay(date, now)) {
    dateString = kTodayString;
  } else if (date.year == now.year && date.month == now.month) {
    int diffInDays = date.day - now.day;
    if (diffInDays == 1) {
      dateString = kTomorrowString;
    } else if (diffInDays == -1) {
      dateString = kYesterdayString;
    } else if (diffInDays >= 2 && diffInDays < 7) {
      dateString = kThisWeekdayStrings[date.weekday - 1];
    } else {
      dateString = date.day.toString();
    }
  } else if (date.year == now.year) {
    dateString = DateFormat('d MMM').format(date).toLowerCase();
  } else {
    dateString = DateFormat('d MMM yyyy').format(date).toLowerCase();
  }

  return dateString;
}

bool isSameDay(DateTime date, DateTime anotherDate) =>
    date.year == anotherDate.year && date.month == anotherDate.month && date.day == anotherDate.day;