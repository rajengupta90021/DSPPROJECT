import 'dart:async';

import 'package:dspuiproject/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../provider/DateTimeProvider.dart';
import 'ReviewOrder.dart';

class BookingDate extends StatefulWidget {
  const BookingDate({Key? key}) : super(key: key);

  @override
  State<BookingDate> createState() => _BookingDateState();
}

class _BookingDateState extends State<BookingDate> {
  DateTime _selectedDay = DateTime.now();
  List<TimeSlot> _slots = [];
  int _selectedSlotIndex = -1;

  @override
  void initState() {
    super.initState();
    _slots = generateTimeSlots(_selectedDay, 9, 20); // 9 AM to 5 PM
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _slots = generateTimeSlots(_selectedDay, 9, 20);
      _selectedSlotIndex = -1;
    });
  }

  List<TimeSlot> generateTimeSlots(DateTime date, int startHour, int endHour) {
    List<TimeSlot> slots = [];
    for (int hour = startHour; hour < endHour; hour++) {
      DateTime startTime = DateTime(date.year, date.month, date.day, hour);
      DateTime endTime = startTime.add(Duration(hours: 1));
      slots.add(TimeSlot(startTime, endTime));
    }
    return slots;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: iconcolor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TableCalendar(
                // firstDay: DateTime.utc(2020, 1, 1),
                firstDay:DateTime.now(),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _selectedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: _onDaySelected,
                calendarFormat: CalendarFormat.month,
              ),
              SizedBox(height: 1),
              Text(
                 'Select Consultation Time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 18),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: List.generate(_slots.length, (index) {
                  TimeSlot slot = _slots[index];
                  bool isSelected = index == _selectedSlotIndex;
                  bool isPast = slot.startTime.isBefore(DateTime.now());
                  return GestureDetector(
                    onTap: slot.startTime.isBefore(DateTime.now())
                        ?  () {
                      _showCustomToast("This time slot is in the past");
                    }
                        : () {
                      setState(() {
                        _selectedSlotIndex = index; // Update selected slot index
                      });
                      Provider.of<DateTimeProvider>(context, listen: false).setSelectedDate(_selectedDay);
                      Provider.of<DateTimeProvider>(context, listen: false).setSelectedTime(
                        _formatTime(slot.startTime),
                        _formatTime(slot.endTime),
                      );
                    },
                    child: SizedBox(
                      width: 100, // Fixed width for each box
                      height: 48, // Fix
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? iconcolor : (isPast ? Colors.grey[300] : Colors.white),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected ? iconcolor : Colors.grey,
                          ),
                        ),
          
                        child: Center(
                          child: Text(
                            '${DateFormat.jm().format(slot.startTime)}',
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: iconcolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 9),
                ),
                onPressed: () {
                  if (_selectedDay != null && _selectedSlotIndex != -1) {
                    // Proceed to review order
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReviewOrder()),
                    );
                  } else {
                    // Show alert if date or time is not selected
                    _showAlertDialog(context);
                  }
                },
                child: Text(
                  'REVIEW YOUR ORDER',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Date and Time'),
          content: Text('Please select both a date and a time to proceed.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _formatTime(DateTime time) {
    int hour = time.hour % 12; // Get the hour in 12-hour format
    if (hour == 0) hour = 12; // Handle midnight (00:00) as 12 AM
    String period = time.hour < 12 ? 'AM' : 'PM'; // Determine AM/PM
    return '$hour:00 $period';
  }

  void _showCustomToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2, // Set duration for iOS web platforms
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // Ensure toast is visible for approximately 1 second by using a timer
    Timer(Duration(milliseconds: 1100), () {
      Fluttertoast.cancel(); // Cancel the toast manually after the desired duration
    });
  }
}

class TimeSlot {
  final DateTime startTime;
  final DateTime endTime;

  TimeSlot(this.startTime, this.endTime);

  String getFormattedDateTime() {
    String startDate = DateFormat.yMMMd().format(startTime); // Format date as 'MMM d, y'
    String startTimeStr = _formatTime(startTime);
    String endTimeStr = _formatTime(endTime);
    return '$startDate - $startTimeStr to $endTimeStr';
  }

  String _formatTime(DateTime time) {
    int hour = time.hour % 12; // Get the hour in 12-hour format
    if (hour == 0) hour = 12; // Handle midnight (00:00) as 12 AM
    String period = time.hour < 12 ? 'AM' : 'PM'; // Determine AM/PM
    return '$hour:00 $period';
  }
}