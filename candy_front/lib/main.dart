import 'package:flutter/material.dart';
import 'colors.dart';
import 'calendar.dart';
import 'chat.dart';
import 'choice.dart';
import 'diaryCom.dart';
import 'diarySum.dart';
import 'emotion.dart';
import 'home.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진과 위젯 트리 바인딩을 보장합니다.
  await initializeDateFormatting('ko_KR', null); // 한국어 로케일 데이터를 초기화합니다.
  runApp(Candy());
}

class Candy extends StatelessWidget {
  const Candy({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CANDY',
      theme: ThemeData(

        fontFamily: 'Kyobo',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

