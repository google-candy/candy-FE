import 'package:flutter/material.dart';
import 'colors.dart';
import 'home.dart';

class EmotionCollectionPage extends StatefulWidget {
  @override
  EmotionCollectionPageState createState() => EmotionCollectionPageState();
}

class EmotionCollectionPageState extends State<EmotionCollectionPage> {

  int selectedIndex = -1;

  //기쁨, 신뢰, 공포, 놀라움, 슬픔, 혐오, 분노, 기대
  final List<Map<String, dynamic>> emotions = [
    {'image': 'assets/e1.png', 'emotion': '기쁨'},
    {'image': 'assets/e2.png', 'emotion': '신뢰'},
    {'image': 'assets/e3.png', 'emotion': '공포'},
    {'image': 'assets/e4.png', 'emotion': '놀라움'},
    {'image': 'assets/e5.png', 'emotion': '슬픔'},
    {'image': 'assets/e6.png', 'emotion': '혐오'},
    {'image': 'assets/e7.png', 'emotion': '분노'},
    {'image': 'assets/e8.png', 'emotion': '기대'},
  ];

  // 선택된 감정에 따른 감정 언어와 레벨 데이터
  final List<Map<String, dynamic>> emotionTags = [
    {
      'emotion': '기쁨',
      'tags': [
        {'tag': '#행복한', 'level': 0.8},
        {'tag': '#즐거운', 'level': 0.6},
        {'tag': '#웃는', 'level': 0.7},
      ],
    },
    {
      'emotion': '신뢰',
      'tags': [
        {'tag': '#믿음직한', 'level': 0.9},
        {'tag': '#안정적인', 'level': 0.65},
        {'tag': '#신뢰', 'level': 0.7},
      ],
    },
    {
      'emotion': '공포',
      'tags': [
        {'tag': '#두려운', 'level': 0.9},
        {'tag': '#무서운', 'level': 0.88},
        {'tag': '#소름끼치는', 'level': 0.85},
      ],
    },
    {
      'emotion': '놀라움',
      'tags': [
        {'tag': '#예기치 못한', 'level': 0.9},
        {'tag': '#감작스러운', 'level': 0.88},
        {'tag': '#신기한', 'level': 0.85},
      ],
    },
    {
      'emotion': '슬픔',
      'tags': [
        {'tag': '#우울한', 'level': 0.9},
        {'tag': '#그리워하는', 'level': 0.88},
        {'tag': '#울먹이는', 'level': 0.85},
      ],
    },
    {
      'emotion': '혐오',
      'tags': [
        {'tag': '#더러운', 'level': 0.9},
        {'tag': '#불쾌한', 'level': 0.88},
        {'tag': '#무례한', 'level': 0.85},
      ],
    },
    {
      'emotion': '분노',
      'tags': [
        {'tag': '#화난', 'level': 0.9},
        {'tag': '#짜증난', 'level': 0.85},
        {'tag': '#불쾌한', 'level': 0.8},
      ],
    },
    {
      'emotion': '기대',
      'tags': [
        {'tag': '#기대하는', 'level': 0.9},
        {'tag': '#희망찬', 'level': 0.88},
        {'tag': '#설레는', 'level': 0.85},
      ],
    },
  ];

  Widget _buildEmotionTag(Map<String, dynamic> tagData) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(tagData['tag']),
            trailing: Text('레벨 ${tagData['level'] * 100}%'),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10), // 둥글기 조절
            child: Container(
              width: 360,
              child: LinearProgressIndicator(
                value: tagData['level'],
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.pointColor3),
                minHeight: 20, // 두께 조절
              ),
            ),
          ),
        ],
      ),
    );
  }


  // 선택된 감정에 따른 감정 태그 리스트를 보여주는 부분
  Widget _buildEmotionTagsList() {
    if (selectedIndex == -1) {
      return Center(child: Text('감정을 선택해 주세요.'));
    }
    // 선택된 감정의 태그 리스트를 가져옵니다.
    List<Map<String, dynamic>> tags = emotionTags[selectedIndex]['tags'];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: tags.map((tagData) => _buildEmotionTag(tagData)).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: AppColors.backGroundColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              '감정 모음집',
              style: TextStyle(fontSize: 30),
            ),
          ),
          centerTitle: true,
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              '나의 감정을 모아요!\n8가지 감정 이모티콘을 클릭하면\n지금까지 모은 감정 데이터를 확인할 수 있어요!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
          ),
          SizedBox(height: 20),

          Container(
            height: 150, // 이모지 리스트의 높이 조절
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: emotions.length, // 이모지 개수
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(width: 1.0, color: Colors
                                  .brown),
                            )
                        ),
                        child: Opacity(
                            opacity: selectedIndex == index ? 1.0 : 0.5,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                          emotions[index]['image'], width: 90,
                                          height: 90),
                                      Flexible(
                                          child: Text(
                                              emotions[index]['emotion'],
                                              style: TextStyle(fontSize: 18)
                                          )
                                      ),
                                    ]
                                )
                            )
                        )
                    )
                );
              },
            ),
          ),

          SizedBox(height: 20,),

          // 선택된 감정에 따른 태그 리스트를 보여주는 스크롤 가능한 부분
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Expanded(
              child: _buildEmotionTagsList(),
            ),
          ),

          SizedBox(height: 30,),

          // 전체 그래프를 나타내는 컨테이너
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // 좌우 패딩
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end, // 자식들을 오른쪽 정렬
                children: [
                  SizedBox(height:5,),
                  Text(
                    '전체 감정 분포',
                    textAlign: TextAlign.right, // 텍스트를 오른쪽으로 정렬
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10), // 둥글기 조절
                    child: SizedBox(
                      height: 30, // 두께 조절
                      child: LinearProgressIndicator(
                        value: selectedIndex != -1 ? emotionTags[selectedIndex]['tags'].fold(0, (previousValue, tag) => previousValue + tag['level']) / emotionTags[selectedIndex]['tags'].length : 0,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                        // minHeight 속성은 여기서는 사용하지 않음
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),


          SizedBox(height: 40),
        ],
      ),
    );
  }
}