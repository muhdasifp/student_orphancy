import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void sendToastMessage({required String message, Color color = Colors.red}) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: color,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
  );
}
