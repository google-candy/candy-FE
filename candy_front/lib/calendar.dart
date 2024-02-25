import 'package:candy2/diaryCom.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'colors.dart';
import 'dart:math';

class CalendarPage extends StatelessWidget {
  final List<String> koreanWeekdays = ['월', '화', '수', '목', '금', '토', '일'];
  final List<String> imageAssets = [
    'assets/e1.png',
    'assets/e2.png',
    'assets/e3.png',
    'assets/e4.png',
    'assets/e5.png',
    'assets/e6.png',
    'assets/e7.png',
    'assets/e8.png',
    'assets/blank.png',
  ];

  final DateTime today = DateTime.now().subtract(Duration(days: 4));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'ko_KR',
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: DateTime.now(),
            daysOfWeekHeight: 80,
            rowHeight: 100,
            calendarStyle: CalendarStyle(cellMargin: EdgeInsets.only(top: 8, bottom: 8)),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(fontSize: 30, color: Colors.black),
            ),
            calendarBuilders: CalendarBuilders(
              todayBuilder: (context, date, events) => _buildTodayCell(context, date),
              defaultBuilder: (context, day, focusedDay) => _buildDefaultCell(context, day, focusedDay),
              outsideBuilder: (context, day, focusedDay) => _buildOutsideCell(context, day, focusedDay),
              dowBuilder: (context, day) => _buildDowCell(context, day),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildTodayCell(BuildContext context, DateTime date) {
    return Container(
      margin: EdgeInsets.all(6.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.pointColor1,
        shape: BoxShape.rectangle,
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 2, blurRadius: 4, offset: Offset(0, 3))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/blank.png'),
          SizedBox(height: 10),
          Text('${date.day}', style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildDefaultCell(BuildContext context, DateTime day, DateTime focusedDay) {
    var rng = Random();
    int imageIndex = day.isAfter(DateTime.now()) ? 8 : rng.nextInt(imageAssets.length);

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DiaryCompletePage())),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imageAssets[imageIndex], width: 50, height: 50),
          SizedBox(height: 10),
          Text('${day.day}', style: TextStyle(color: Colors.black, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildOutsideCell(BuildContext context, DateTime day, DateTime focusedDay) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DiaryCompletePage())),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(opacity: 0.0, child: Image.asset('assets/blank.png')),
          SizedBox(height: 10),
          Text('${day.day}', style: TextStyle(color: Colors.grey, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildDowCell(BuildContext context, DateTime day) {
    final String dayText = koreanWeekdays[day.weekday - 1];
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Center(
        child: Text(dayText, style: TextStyle(color: day.weekday == 7 ? Colors.red : day.weekday == 6 ? Colors.blue : Colors.black, fontSize: 21)),
      ),
    );
  }
}