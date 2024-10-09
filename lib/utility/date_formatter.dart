import 'package:cloud_firestore/cloud_firestore.dart';

String dateFormatter(DateTime date) {
  return "${date.day}.${date.month}.${date.year}";
}

String timeFormatter(Timestamp time) {
  final DateTime data = time.toDate();
  return "${data.hour}:${data.minute}";
}
