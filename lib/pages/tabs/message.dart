import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/pages/tabs/scorewidget/message_card.dart';
import 'package:intl/intl.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final TextEditingController _messageController = TextEditingController();
  String _result = '';
  List<String> _messages = [];
  bool _isLoading = false;

  void _sendMessage(String message) async {
    setState(() {
      _messages.add(message);
      _isLoading = true;
    });

    await _fetchData(message + "(回答不要超过250字且回答不要分段)");

    setState(() {
      _messages.add(_result);
      _isLoading = false;
    });
    _messageController.clear();
    _result = '';
  }

  double screenWith(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  String getCurrentTime() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    String formattedTime = formatter.format(now);
    return formattedTime;
  }

  Future<void> _fetchData(String inputText) async {
    try {
      var dio = Dio();
      final response = await dio.get('http://127.0.0.1:5000/hello?message=$inputText');
      if (response.statusCode == 200) {
        setState(() {
          _result = response.data["ai回答"];
        });
      } else {
        setState(() {
          _result = "错误：${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _result = "无法加载数据：$e";
        print(_result);
      });
    }
  }

  Widget _buildMessageList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _messages.length,
        itemBuilder: (BuildContext context, int index) {
          // return ListTile(
          //   title: Text(_messages[index]),
          // );
          return MessageCard( messageText: _messages[index],index:index,sentTime: getCurrentTime());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildMessageList(),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            //语言功能
                          },
                          child: Container(
                            height: 28,
                            width: 28,
                            margin: const EdgeInsets.only(right: 10),
                            child: const Image(
                              image: AssetImage(
                                  'assets/images/brand_profile_voice@2x.png'),
                            ),
                          )),
                      Container(
                          width: screenWith(context) - 120,
                          height: 34.0,
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 8.0, right: 8.0),
                            // 右边留有一些空间
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey, // 边框颜色
                                        width: 1.0, // 边框宽度
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(10.0), // 边框圆角
                                    ),
                                    child: TextField(
                                      controller: _messageController,
                                      cursorColor: Colors.grey,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: '输入文字开始和ai聊天吧......',
                                        contentPadding: EdgeInsets.only(
                                            left: 5.0,
                                            right: 5.0,
                                            bottom: 14.0),
                                        border: InputBorder.none,
                                      ),
                                      onSubmitted: (String value) {
                                        if (value.isNotEmpty) {
                                          _sendMessage(value);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          String message = _messageController.text.trim();
                          if (message.isNotEmpty) {
                            _sendMessage(message);
                          }
                        },
                      ),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}


