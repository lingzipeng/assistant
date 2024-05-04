import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../service/api_service.dart';
import '../score/sheet.dart';

class table extends StatefulWidget {
  const table({super.key});
  @override
  State<table> createState() => _tableState();
}

class User {
  final String className;
  final String name;
  final String stuno;
  final int mathScore;
  final int chineseScore;
  final int englishScore;

  User({
    required this.className,
    required this.name,
    required this.stuno,
    required this.mathScore,
    required this.chineseScore,
    required this.englishScore,
  });
}

class _tableState extends State<table> {

  late List<User> responseData;
  late Map<String, List<User>> groupedData = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      Response response = await APIService.fetchData();
      final data = response.data['result'];

      setState(() {
        responseData = [];
        data.values.forEach((studentData) {
          if (studentData != null &&
              studentData is Map<String, dynamic> &&
              studentData.containsKey('classname') &&
              studentData.containsKey('name') &&
              studentData.containsKey('stuno') &&
              studentData.containsKey('数学') &&
              studentData.containsKey('语文') &&
              studentData.containsKey('英语')) {
            responseData.add(User(
              className: studentData['classname'] ?? '',
              name: studentData['name'] ?? '',
              stuno: studentData['stuno'] ?? '',
              mathScore: studentData['数学'] ?? 0,
              chineseScore: studentData['语文'] ?? 0,
              englishScore: studentData['英语'] ?? 0,
            ));

          }
        });

      });
    } catch (e) {
      setState(() {
        responseData = [];
      });
    }
    groupedData = {};
    for (var user in responseData) {
      if (!groupedData.containsKey(user.className)) {
        groupedData[user.className] = [];
      }
      groupedData[user.className]!.add(user);
    }
    // print(groupedData);
  }

  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              DropdownButton<String>(
                // 设置下拉菜单按钮的提示文本
                hint: Text('班级选择'),
                // 设置下拉菜单中的所有选项
                items: <String>['三年级1班', '三年级2班', '三年级3班', '三年级4班', '三年级5班']
                    .map((String value) {
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
              ElevatedButton(
                onPressed: () {
                  print(groupedData[_selectedOption]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Sheet(groupedData[_selectedOption] ?? [])),
                  );
                },
                child: Text('成绩'),
              ),
            ],
          )),
    );
  }
}
