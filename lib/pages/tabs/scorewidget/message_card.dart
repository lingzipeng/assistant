import 'package:flutter/material.dart';


class MessageCard extends StatelessWidget {
  final String messageText;
  final String sentTime;
  final int index;

  const MessageCard(
      {super.key, required this.messageText, required this.index, required this.sentTime});

  @override
  Widget build(BuildContext context) {
    return index % 2==0 ? Column(
        children: [
        Text(sentTime,
            style: const TextStyle(fontSize: 13, color: Colors.black54)),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   width: 100.0,
            // ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: const BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                constraints: BoxConstraints(maxWidth: 300),
                child: Text(
                  messageText,
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ),
            ),
            const Column(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image(
                    image: AssetImage("assets/images/xiaoheizi.jpg"),
                    fit: BoxFit.cover, // 设置图片填充方式
                  ),
                )
              ],
            ),
          ],
        ),
      ]
    ):Column(
        children: [
          Text(sentTime,
              style: const TextStyle(fontSize: 13, color: Colors.black54)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   width: 100.0,
              // ),
              const Column(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Image(
                      image: AssetImage("assets/images/DefaultProfileHead_kf@3x.png"),
                      fit: BoxFit.cover, // 设置图片填充方式
                    ),
                  )
                ],
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: const BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  constraints: BoxConstraints(maxWidth: 300),
                  child: Text(
                    messageText,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                ),
              ),
            ],
          ),
        ]
    );
  }
}
