import 'package:candy2/diarySum.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'dart:math';
import 'emotion.dart';

class EmojiSelectionPage extends StatefulWidget {
  @override
  EmojiSelectionPageState createState() => EmojiSelectionPageState();
}

class EmojiSelectionPageState extends State<EmojiSelectionPage> {

  int? selectedEmojiIndex;

  void _selectEmoji(int index) {
    setState(() {
      selectedEmojiIndex = index;
    });
  }


  final List<Map<String, dynamic>> allEmojis = [
    {'image': 'assets/e1.png', 'emoji': '기쁨', 'english': 'Joy'},
    {'image': 'assets/e2.png', 'emoji': '신뢰', 'english': 'Trust'},
    {'image': 'assets/e3.png', 'emoji': '공포', 'english': 'Fear'},
    {'image': 'assets/e4.png', 'emoji': '놀라움', 'english': 'Surprise'},
    {'image': 'assets/e5.png', 'emoji': '슬픔', 'english': 'Sadness'},
    {'image': 'assets/e6.png', 'emoji': '혐오', 'english': 'Disgust'},
    {'image': 'assets/e7.png', 'emoji': '분노', 'english': 'Anger'},
    {'image': 'assets/e8.png', 'emoji': '기대', 'english': 'Anticipation'},

  ];

  // 화면에 표시될 4개의 이모지와 감정 단어 목록
  List<Map<String, dynamic>> displayedEmojis = [];

  @override
  void initState() {
    super.initState();
    _updateDisplayedEmojis();
  }

  // 랜덤으로 4개의 이모지와 감정 단어를 선택하여 업데이트하는 함수
  void _updateDisplayedEmojis() {
    final random = Random();
    List<Map<String, dynamic>> shuffledEmojis = List.from(allEmojis)..shuffle(random);

    displayedEmojis = shuffledEmojis.take(4).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        title: Text("감정 선택"),
        backgroundColor: AppColors.backGroundColor,
      ),
      body: Column(
        children: [
          // 상단 박스
          Container(
            padding: EdgeInsets.all(16),
            height: 100,
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // 그림자 색상
                  spreadRadius: 0, // 그림자 확산 반경
                  blurRadius: 7, // 그림자 흐림 정도
                  offset: Offset(0, 5), // 그림자 위치 조정
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0), // 왼쪽에 공간 추가
                  child: Text('오늘의 감정 고르기', style: TextStyle(fontSize: 27)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0), // 왼쪽에 공간 추가
                  child: Text('가장 인상 깊었던 감정을 한가지 선택해줘', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // 4개의 버튼 (2x2 형태)
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (1 / 1.2), // 아이템의 가로 세로 비율
              crossAxisSpacing: 10, // 항목 사이의 가로 간격
              mainAxisSpacing: 10, // 항목 사이의 세로 간격
              padding: EdgeInsets.all(10), // GridView의 패딩을 설정하여 항목과의 여백 생성
              physics: NeverScrollableScrollPhysics(),

              children: List.generate(displayedEmojis.length, (index) {
                return Material(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedEmojiIndex == index ? Colors.orange : Colors.amber.shade100,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      padding: EdgeInsets.zero,
                    ),
                  
                    onPressed: () => _selectEmoji(index),
                  
                    child: LayoutBuilder(
                      builder: (context, constraints) => Stack(
                        //alignment: Alignment.center,
                        children: [
                          // 이미지
                  
                          Align(
                            alignment: Alignment(0.0, -0.3),
                            child: Image.asset(
                              displayedEmojis[index]['image'],
                              height: 130, // 이미지 높이 조절
                              width: 130, // 이미지 너비 조절
                              fit: BoxFit.cover, // 이미지가 컨테이너를 꽉 채우도록 설정
                            ),
                          ),
                  
                          // 텍스트
                          Positioned( // Align 위젯을 사용하여 텍스트 위치 조정
                            top: constraints.maxHeight*0.77,
                            left: constraints.maxWidth / 6, // 이미지를 가로축의 중앙에 배치하기 위해
                            right: constraints.maxWidth / 6,
                  
                            child: Text(
                              displayedEmojis[index]['emoji'],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                  
                          // 물음표 아이콘
                          Positioned( // 위치를 정확하게 지정할 수 있는 Positioned 위젯 사용
                            top: 5, // 상단에서 5픽셀 떨어진 위치
                            right: 5, // 우측에서 5픽셀 떨어진 위치
                            child: IconButton(
                              icon: Icon(Icons.question_mark),
                  
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 470,
                                            width: 350,
                                            padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              color: Colors.amber.shade100,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                  
                  
                                                Text(displayedEmojis[index]['emoji'],
                                                    style: TextStyle(fontSize: 30)
                                                ),
                  //Text(),
                                                Text("( " + displayedEmojis[index]['english'] + ")",
                                                  style: TextStyle(fontSize: 22, color:Colors.grey,),
                                                ),
                  //Text(),
                                                SizedBox(height: 20),
                  
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: <Widget>[
                                                    Image.asset(
                                                      displayedEmojis[index]['image'],
                                                      height:135, width: 135,
                                                      fit: BoxFit.contain,
                                                    ), // 이미지 추가
                  
                                                    SizedBox(width: 20),
                  
                                                    Column(
                                                      children: [
                                                        Container(
                                                          height: 40, width: 130,
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.5), // 컨테이너의 배경색을 투명하게 설정
                                                            borderRadius: BorderRadius.circular(15),
                                                          ),
                                                          child: Text(" # 행복한 ",
                                                              textAlign: TextAlign.center,
                                                              style:(
                                                                  TextStyle(
                                                                    fontSize: 26,
                                                                  )
                                                              )
                                                          ),
                                                        ),
                                                        SizedBox(height: 5,),
                                                        Container(
                                                          height: 40, width: 130,
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.5), // 컨테이너의 배경색을 투명하게 설정
                                                            borderRadius: BorderRadius.circular(15),
                                                          ),
                                                          child: Text(" # 즐거운 ",
                                                              textAlign: TextAlign.center,
                                                              style:(
                                                                  TextStyle(
                                                                    fontSize: 26,
                                                                  )
                                                              )
                                                          ),
                                                        ),
                                                        SizedBox(height: 5,),
                                                        Container(
                                                          height: 40, width: 130,
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.5), // 컨테이너의 배경색을 투명하게 설정
                                                            borderRadius: BorderRadius.circular(15),
                                                          ),
                                                          child: Text(" # 산뜻한 ",
                                                              textAlign: TextAlign.center,
                                                              style:(
                                                                  TextStyle(
                                                                    fontSize: 26,
                                                                  )
                                                              )
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                  
                                                SizedBox(height: 25),
                  
                                                Container(
                                                  height: 160, width: 300,
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(15),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text("\"기쁘다\"는 느낌이나 상태를 나타내는 한국어 단어로, 마음이 행복하고 즐거운 상태를 의미해요. 어떤 좋은 일이 생겼거나, 만족스러운 결과를 얻었을 때, 또는 사랑하는 사람들과 함께 있을 때 이런 기분을 느껴요.",
                                                        style:(
                                                            TextStyle(
                                                              fontSize: 18,
                                                            )
                                                        )
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            right: 4,
                                            top: 4,
                                            child: IconButton(
                                              icon: Icon(Icons.close, size: 24),
                                              onPressed: () {
                                                Navigator.of(context).pop(); // 다이얼로그 닫기
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                  
                            )
                  
                          ),
                  
                        ],
                      ),
                    ),
                  
                  ),
                );
              }),
            ),
          ),


          // 하단 설명 텍스트
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(Icons.question_mark),

              Text('를 누르면 더 자세한 설명을 볼 수 있어요',
                style: TextStyle(fontSize: 18,),
              ),
            ],
          ),

          SizedBox(height: 10,),

          // 하단 버튼 두 개
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.pointColor3, // 버튼 색상
                  foregroundColor: Colors.black, // 버튼 텍스트 색상
                  minimumSize: Size(170, 50), // 버튼 크기
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _updateDisplayedEmojis(); // 버튼을 누를 때마다 새로운 이모지와 감정 단어를 랜덤으로 선택
                  });
                },
                child: Text(
                  '다른 감정\n 보러가기',
                  style: TextStyle(fontSize: 18),
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.pointColor3, // 버튼 색상
                  foregroundColor: Colors.black, // 버튼 텍스트 색상
                  minimumSize: Size(170, 50), // 버튼 크기
                  shape: RoundedRectangleBorder( // 모서리를 각지게 설정
                    borderRadius: BorderRadius.circular(10), // 0은 완전 각진 모서리
                  ),
                ),
                onPressed: () {
                  if (selectedEmojiIndex != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiarySummaryPage(
                          selectedEmotion: displayedEmojis[selectedEmojiIndex!]['emoji'],
                          emojiImage: displayedEmojis[selectedEmojiIndex!]['image'],
                        ),
                      ),
                    );
                  } else {
                    // 선택되지 않았을 경우 사용자에게 알림
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('감정 카드를 선택해주세요!')),
                    );
                  }
                },
                child: Text(
                    '선택 완료',
                    style: TextStyle(
                      fontSize: 24,
                    )
                ),

              ),
            ],
          ),

          SizedBox(height: 80),

        ],
      ),
    );
  }
}