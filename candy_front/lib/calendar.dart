import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'colors.dart';

class CalendarPage extends StatelessWidget {

  final List<String> koreanWeekdays = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      // appBar: AppBar(
      //   title: Text('캘린더',
      //       style: TextStyle(
      //         fontSize: 28,
      //       )),
      //   backgroundColor: AppColors.backGroundColor,
      // ),

      body: Column(
        children: [

          SizedBox(height: 100),

          TableCalendar(
            locale: 'ko_KR',
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: DateTime.now(),
            daysOfWeekHeight: 80,
            rowHeight: 100,

            calendarStyle: CalendarStyle(
              cellMargin: EdgeInsets.only(top: 8 ,bottom: 8),
              //cellPadding: EdgeInsets.all(5),
            ),

            headerStyle: HeaderStyle(
              formatButtonVisible: false, // 포맷 버튼 숨기기
              titleCentered: true,
              titleTextStyle: TextStyle(
                fontSize: 30, color: Colors.black,
              ),

              //leftChevronVisible: false, // 좌측 체브론 숨기기
              //rightChevronVisible: false, // 우측 체브론 숨기기
            ),

            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                color: Colors.black, // 평일 텍스트 색상
                //fontSize: 20, // 평일 텍스트 크기
              ),
              weekendStyle: TextStyle(
                color: Colors.red, // 주말 텍스트 색상 (토요일은 blue로 이미 정의됨)
                //fontSize: 20, // 주말 텍스트 크기
              ),
            ),

            calendarBuilders: CalendarBuilders(

              todayBuilder: (context, date, events) {
                return Container(
                  margin: EdgeInsets.all(6.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.pointColor1, // 오늘 날짜의 배경색
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // 그림자 색상과 투명도
                        spreadRadius: 2, // 그림자의 범위를 얼마나 넓힐지
                        blurRadius: 4, // 흐림 정도
                        offset: Offset(0, 3), // 그림자의 위치
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // 세로 중앙 정렬
                    children: [
                      Image.asset('assets/blank.png'),
                      SizedBox(height: 10),
                      Text(
                        '${date.day}',
                        style: TextStyle(color: Colors.black), // 오늘 날짜의 텍스트 색상
                      ),
                    ],
                  ),
                );
              },

              defaultBuilder: (context, day, focusedDay) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center, // 세로 중앙 정렬
                  children: [
                    Image.asset('assets/blank.png'),
                    SizedBox(height: 10),
                    Text(
                      '${day.day}',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                );
              },
              outsideBuilder: (context, day, focusedDay) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center, // 세로 중앙 정렬
                  children: [
                    // 현재 달의 날짜 셀에 사용된 아이콘과 동일한 높이의 공간을 만듭니다.
                    // 아이콘이 없으면 SizedBox를 제거하거나 높이를 0으로 설정하세요.
                    Opacity(
                      opacity: 0.0,
                      child: Image.asset('assets/blank.png'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${day.day}',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                );
              },

              dowBuilder: (context, day) {
                final String dayText = koreanWeekdays[day.weekday - 1];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Center(
                      child: Text(
                        dayText,
                        style: TextStyle(
                          color: day.weekday == 7 ? Colors.red : // 일요일
                                day.weekday == 6 ? Colors.blue : // 토요일
                                Colors.black, // 평일
                          fontSize: 21,
                        ),
                      ),
                    ),
                );
              },
            ),



            // ... 여기에 다른 TableCalendar 설정을 추가할 수 있습니다.
          ),
          // ... 기타 필요한 위젯들
        ],
      ),
    );
  }
}
