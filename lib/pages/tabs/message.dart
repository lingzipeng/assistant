import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Dio dio = Dio();
  String responseData = '';

  // 发起HTTP请求并更新UI
  void fetchData() async {
    try {
      // 构建Authorization头
      // Options options = Options(
      //   headers: {
      //     'Authorization':
      //         'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYmYiOjE3MTM1OTkwMzcs'
      //             'ImV4cCI6MTcxMzYwNjIzNywiaWF0IjoxNzEzNTk5MDM3LCJhaWQiOjE1LCJ1c2VybmFtZSI6ImF'
      //             'kbWluIn0.38MNo7-V-TWNmkL75Z4WgtgJdcAV4FEtpv1jQjccDzQ',
      //   },
      // );
      Response response =
          await dio.get('http://localhost:8080/scores/allScoresCensus');
      setState(() {
        responseData = response.data.toString();
      });
    } catch (e) {
      setState(() {
        responseData = 'Error: $e';
      });
    }
  }
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: fetchData,
              child: Text('班级成绩'),
            ),
            SizedBox(height: 20),
            // Text(
            //   '班级选择======科目选择',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // 设置水平方向居中对齐
              children: [
                DropdownButton<String>(
                  // 设置下拉菜单按钮的提示文本
                  hint: Text('班级选择'),
                  // 设置下拉菜单中的所有选项
                  items: <String>[
                    '三年级一班',
                    '三年级二班',
                    '三年级三班',
                    '三年级四班',
                    '三年级五班'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  // 当用户选择一个选项时调用的回调函数
                  onChanged: (String? newValue) {
                    // 在用户选择时更新选中的值，并重新构建小部件以更新UI
                    setState(() {
                      _selectedOption = newValue;
                    });
                  },
                  // 设置默认选中的选项
                  value: _selectedOption,
                ),
                DropdownButton<String>(
                  // 设置下拉菜单按钮的提示文本
                  hint: Text('班级选择'),
                  // 设置下拉菜单中的所有选项
                  items: <String>[
                    '语文',
                    '数学',
                    '英语'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  // 当用户选择一个选项时调用的回调函数
                  onChanged: (String? newValue) {
                    // 在用户选择时更新选中的值，并重新构建小部件以更新UI
                    setState(() {
                      _selectedOption = newValue;
                    });
                  },
                  // 设置默认选中的选项
                  value: _selectedOption,
                )
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  responseData,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
