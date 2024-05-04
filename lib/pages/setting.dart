import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/globals_provider.dart'; // 导入全局Provider

class settingPage extends StatefulWidget {
  @override
  _settingPageState createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<int> globalArray = Provider.of<GlobalArrayProvider>(context).globalArray;

    return Scaffold(
      appBar: AppBar(
        title: Text('密码修改'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '密码: ${globalArray.join("")}', // 将密码数组连接成字符串显示
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: '输入如”6789“',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 解析用户输入的字符串为数组
                List<int> newArray = [];
                for (int i = 0; i < _textController.text.length; i++) {
                  int? digit = int.tryParse(_textController.text[i]);
                  if (digit != null) {
                    newArray.add(digit);
                  }
                }
                Provider.of<GlobalArrayProvider>(context, listen: false).globalArray = newArray;
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent), // 按钮背景色
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0), // 按钮圆角
                  ),
                ),
              ),
              child: Text('修改密码'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // 释放控制器资源
    _textController.dispose();
    super.dispose();
  }
}
