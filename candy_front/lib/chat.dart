import 'package:candy2/choice.dart';
import 'package:candy2/diaryCom.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class ChatPage extends StatefulWidget {
  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  int botQuestionCount = 0; // 챗봇이 질문한 횟수를 추적하는 변수

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => focusNode.requestFocus());

    addBotStartMessage();
  }

  void addBotStartMessage() {
    ChatMessage startMessage = ChatMessage(
      isUserMessage: false,
      text: "안녕하세요! 무엇을 도와드릴까요?", // 챗봇의 시작 메시지
      botAvatarPath: 'assets/aiprofile.png',
    );

    setState(() {
      _messages.add(startMessage); // 메시지 리스트에 시작 메시지를 추가
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    focusNode.dispose(); // FocusNode를 dispose 해야 합니다.
    super.dispose();
  }

  void _handleSubmitted(String text) {
    _textController.clear();

    // 사용자 메시지 처리
    ChatMessage userMessage = ChatMessage(
      isUserMessage: true,
      text: text,
    );

    setState(() {
      _messages.add(userMessage); // 사용자 메시지를 리스트에 추가
      if (botQuestionCount < 5) {
        // 일반 챗봇 응답을 생성하고 질문 횟수를 증가시킵니다.
        ChatMessage botResponse = ChatMessage(
          isUserMessage: false,
          text: "챗봇의 응답",
          botAvatarPath: 'assets/aiprofile.png',
        );
        _messages.add(botResponse);
        botQuestionCount++;
      }

      // 챗봇이 5번 질문한 후 사용자가 메시지를 보내면 "감정 고르기" 메시지를 추가합니다.
      if (botQuestionCount == 5) {
        String beforeSummary = "그럼 이제 오늘의 대화를 일기로 정리해볼까?";
        String summaryText = "요약본"; // 여기에 추가하고 싶은 텍스트를 넣습니다.
        String afterSummary = "먼저 오늘의 감정을 골라보자";

        ChatMessage emotionMessage = ChatMessage(
          isUserMessage: false,
          text: "$beforeSummary\n\n$summaryText\n\n$afterSummary",
          botAvatarPath: null,
          onEmotionSelected: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EmojiSelectionPage()),
            );
          },
        );
        _messages.add(emotionMessage);
        botQuestionCount++; // 이후 추가 질문을 막기 위해 botQuestionCount를 증가시킵니다.
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('일기장 쓰기'),
        centerTitle: true,
      ),

      body: Column(
        children: [
          SizedBox(height:20,),

          // 날짜 박스
          Container(
            height: 40, width: 120,
            decoration: BoxDecoration(
              color: Colors.grey, // 여기에서 원하는 배경색을 설정하세요.
              borderRadius: BorderRadius.circular(16), // 모서리 둥글기 정도를 설정하세요.
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text('2024.01.20.월', style: TextStyle(color: Colors.white)),
            ),
          ),

          SizedBox(height:20),


          // 채팅 메시지 리스트
          Expanded(
            child: ListView.builder(
              reverse: false, // 이 부분을 확인하세요.
              itemCount: _messages.length,
              itemBuilder: (context, index) => _messages[index],
            ),
          ),


          // 메시지 입력 필드
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: AppColors.pointColor2, // 여기에 원하는 배경색을 설정하세요.
            ),

            child: Center(
              child: Container(
                margin:EdgeInsets.only(bottom:10.0),
                decoration: BoxDecoration(
                  color: Colors.white, // 여기에 원하는 배경색을 설정하세요.
                  borderRadius: BorderRadius.circular(20), // 선택사항: 모서리를 둥글게 할 수 있습니다.
                ),

                child: TextField(
                  autofocus: true,
                  focusNode: focusNode, // FocusNode 할당
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: '메시지를 입력하세요',
                    contentPadding: EdgeInsets.only(left: 10.0),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        if (_textController.text.isNotEmpty) {
                          _handleSubmitted(_textController.text);
                          focusNode.requestFocus(); // 전송 후에도 포커스를 유지
                        }
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),

                  onTap: () {
                    if (focusNode.hasFocus) {
                      focusNode.unfocus();
                      Future.delayed(Duration.zero, () => focusNode.requestFocus());
                    } else {
                      focusNode.requestFocus();
                    }
                  },

                  onSubmitted: (String text) {
                    _handleSubmitted(text);
                    focusNode.requestFocus(); // 전송 후에도 포커스를 유지
                  },
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}


// 채팅 메시지 위젯
class ChatMessage extends StatelessWidget {
  final bool isUserMessage;
  final String text;
  final String? botAvatarPath;
  final VoidCallback? onEmotionSelected;

  const ChatMessage({
    Key? key,
    required this.isUserMessage,
    required this.text,
    this.botAvatarPath,
    this.onEmotionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget botProfileImage = botAvatarPath != null
        ? Padding(
            padding: EdgeInsets.only(left: 12.0), // 여기에서 챗봇 이미지의 왼쪽 패딩을 조정합니다.
            child: CircleAvatar(backgroundImage: AssetImage(botAvatarPath!)),
          )
        : SizedBox(width:55,); // null일 경우 아무것도 표시하지 않음

    // 메시지 텍스트를 포함하는 컨테이너
    Widget messageContainer = Container(
      margin: EdgeInsets.only(
        left: isUserMessage ? 0 : 8.0, // 챗봇 메시지 왼쪽에 여백 추가
        right: isUserMessage ? 8.0 : 0, // 사용자 메시지 오른쪽에 여백 추가
      ),
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: isUserMessage ? Colors.transparent : Colors.transparent, // 이미지 사용 시 색상을 투명으로 설정
        borderRadius: BorderRadius.circular(16), // 말풍선 모양에 맞게 조정
        image: DecorationImage(
          image: AssetImage(
            isUserMessage ? "assets/mycloud.png" : "assets/chatcloud.png", // 조건부 이미지 경로
          ),
          fit: BoxFit.fill, // 이미지가 컨테이너를 꽉 채우도록 설정
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text), // 메시지 텍스트
          if (onEmotionSelected != null) // "감정 고르기" 버튼 조건부 추가
            Padding(
              padding: const EdgeInsets.only(top: 8.0,), // 버튼과 텍스트 사이 간격
              child: ElevatedButton(
                onPressed: onEmotionSelected,
                child: Text('감정 고르기'),
              ),
            ),
        ],

      ),
    );

    Widget spaceBetweenImageAndMessage = SizedBox(width: 5);

    Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        if (onEmotionSelected != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0), // 버튼과 텍스트 사이 간격
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.pointColor1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
              onPressed: onEmotionSelected,
              child: Text('감정 고르기',
                  style: TextStyle(fontSize: 18, color: Colors.black,) ),
            ),
          ),
        if (onEmotionSelected != null) SizedBox(height: 40), // 버튼 아래에 추가 공간
      ],
    );



    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUserMessage) botProfileImage,
          if (!isUserMessage) spaceBetweenImageAndMessage, // 여기에 공간 추가
          messageContainer,
        ],
      ),
    );
  }
}