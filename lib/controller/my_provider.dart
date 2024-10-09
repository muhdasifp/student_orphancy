import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  bool isLoading = false;


  ///used for circular progress indicator while clicking a button with future function
  toggle() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
