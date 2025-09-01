import 'package:intl/intl.dart';

String formatDate(DateTime dateTime, {String format = "MM-dd HH:mm"}) {
  return DateFormat(format).format(dateTime);
}
