import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_be_named/core/Colors.dart';
import 'DetailsScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime today = DateTime.now();
  void onDaySelected (DateTime day, DateTime focusDay) {
    setState(() {
      today = focusDay;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DayDetailsScreen(selectedDate: day),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("pick a Date"),
      ),
      body: Center(
        child: TableCalendar(
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
                color: MyColors.dates,
                shape: BoxShape.circle
            ),
          ),
          rowHeight: 39,
          headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
          availableGestures: AvailableGestures.all,
          selectedDayPredicate: (day) => isSameDay(day, today),
          focusedDay: today,
          firstDay: DateTime.now(),
          lastDay: DateTime.utc(2030, 3, 10),
          onDaySelected: onDaySelected,
        ),
      ),
    );
    }
}