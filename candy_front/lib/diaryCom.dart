import 'package:flutter/material.dart';
import 'colors.dart';
import 'home.dart';

class DiaryCompletePage extends StatelessWidget {
  final String selectedEmotion = '행복';
  final String emotionDescription = '좋은 일이 있었어'; // 이모지 설명
  final String dateSummary = '2024.02.215'; // 날짜
  final String chatSummary = '오늘은 길고 피곤한 날이었지만, 시간이 빠르게 지나가는 것에 아쉬움을 느끼며, 나의 성장을 되돌아봤다☺️ 구글 솔루션 챌린지 프로젝트에 참여하며, 백엔드 개발자로서 새로운 도전과 경험을 쌓고 있다😚 어려움 속에서도 붕어빵과 같은 작은 행복을 찾으며, 긍정적인 에너지를 얻었다💪🏼 오늘 하루 동안 많은 일이 있었지만, 그 속에서 소중한 순간을 찾고, 내일을 향한 기대감을 갖게 되었다😎🥰'; // 채팅 요약본

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        title: Text('일기 요약본'),
        backgroundColor: AppColors.backGroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),

          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                // 이모지 카드
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // 모서리를 둥글게 하기 위한 BorderRadius
                  ),
                  child: Container(
                    width: 200,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100, // Container의 배경색은 여기에 지정
                      borderRadius: BorderRadius.circular(30), // Container에도 동일한 BorderRadius 적용
                    ),
                    child: Stack(
                      children: <Widget>[

                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: Image.asset(
                            'assets/e1.png',
                            height: 130, // 이미지 높이 조절
                            width: 130, // 이미지 너비 조절
                            fit: BoxFit.cover, // 이미지가 컨테이너를 꽉 채우도록 설정
                          ),
                        ),

                        Positioned(
                          bottom: 20, // 하단으로부터 20 픽셀 위치에 텍스트를 배치
                          left: 20, // 왼쪽으로부터 20 픽셀
                          right: 20, // 오른쪽으로부터 20 픽셀
                          child: Text(
                            selectedEmotion,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 28), // 텍스트 스타일 조절
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // 일기 요약 상자
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100, // 여기에서 배경색을 설정합니다.
                      borderRadius: BorderRadius.circular(20), // 둥근 모서리 반경을 설정합니다.
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(dateSummary, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10,),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(chatSummary, style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(300,50),
                            backgroundColor: AppColors.pointColor3,
                            foregroundColor: Colors.black, // 버튼 색상은 디자인에 맞추어 조정하세요.
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30), // 버튼의 둥근 모서리를 설정합니다.
                            ),
                          ),
                          child: Text(
                              '처음 화면으로 가기',
                              style: TextStyle(
                                fontSize: 24,
                              )
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            ); // 홈페이지로 이동하는 로직
                          },
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}