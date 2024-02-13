import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 控制输入框的内容
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: '用户名',
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '密码',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 获取输入的用户名和密码
                String enteredUsername = _usernameController.text;
                String enteredPassword = _passwordController.text;

                // 验证用户名和密码是否为预设的 "123"
                if (enteredUsername == '123' && enteredPassword == '123') {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                } else {
                  // 如果验证失败，可以显示错误消息或者其他处理逻辑
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('登录失败'),
                        content: Text('用户名或密码不正确，请重新输入。'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('确定'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('登录'),
            ),
          ],
        ),
      ),
    );
  }
}
