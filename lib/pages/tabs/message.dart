import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('教师信息'),
      ),
      body: const Column(
        children: [
          Divider(color: Colors.grey), // 添加分割线
          ChatMessage(message: '群消息', unreadCount: 10),
          Divider(color: Colors.grey), // 添加分割线
          ChatMessage(message: '张老师的消息', unreadCount: 3),
          Divider(color: Colors.grey), // 添加分割线
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isTeacher;
  final int? unreadCount;

  const ChatMessage({
    required this.message,
    this.isTeacher = false,
    this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          isTeacher ? Colors.blue.withOpacity(0.1) : Colors.white, // 设置不同背景颜色
      child: ListTile(
        title: Row(
          children: [
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontWeight: isTeacher ? FontWeight.bold : FontWeight.normal,
                  fontSize: 25, // 设置字体大小为18
                ),
              ),
            ),
            if (unreadCount != null && unreadCount! > 0) ...[
              SizedBox(width: 10),
              UnreadIndicator(count: unreadCount!),
            ],
          ],
        ),
      ),
    );
  }
}

class UnreadIndicator extends StatelessWidget {
  final int count;

  const UnreadIndicator({
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        '未读消息$count条',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}
