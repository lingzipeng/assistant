import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../service/globals_provider.dart'; // 导入全局Provider

class settingPage extends StatefulWidget {
  @override
  _settingPageState createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  TextEditingController _textController = TextEditingController();
  TextEditingController _textController1 = TextEditingController();

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
            // Text(
            //   '密码: ${globalArray.join("")}', // 将密码数组连接成字符串显示
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(height: 20),
            Container(
              width: 200,
              child: TextField(
                controller: _textController1,
                obscureText: true, // 隐藏输入的密码
                decoration: InputDecoration(
                  hintText: '请输入旧密码“',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: '新密码，例如输入如”6789“',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //验证密码是否正确
                // 获取用户输入的旧密码和新密码
                String oldPassword = _textController1.text;
                String newPassword = _textController.text;

                // 获取存储的旧密码
                String storedPassword = globalArray.join("");
                if (oldPassword == storedPassword) {
                  // 解析用户输入的新密码并更新密码
                  List<int> newArray = [];
                  for (int i = 0; i < newPassword.length; i++) {
                    int? digit = int.tryParse(newPassword[i]);
                    if (digit != null) {
                      newArray.add(digit);
                    }
                  }
                  Provider.of<GlobalArrayProvider>(context, listen: false).globalArray = newArray;
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(
                  //     content: Text('密码修改成功'),
                  //     duration: Duration(seconds: 2),
                  //   ),
                  // );
                  _textController.clear(); // 清空新密码输入框
                  _textController1.clear(); // 清空旧密码输入框
                  Fluttertoast.showToast(
                    msg: "密码正确,修改成功",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('密码错误，请重新输入'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
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
