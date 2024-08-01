import 'package:flutter/material.dart';

class DateTimeProvider extends ChangeNotifier {
  DateTime? selectedDate;
  String? selectedStartTime;
  String? selectedEndTime;

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void setSelectedTime(String startTime, String endTime) {
    selectedStartTime = startTime;
    selectedEndTime = endTime;
    notifyListeners();
  }
}
