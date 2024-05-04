import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../chart/class_chart.dart';
import '../../service/api_service.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late List<User> responseData;
  String? _selectedClass;
  String? _selectedSubject;

  //展示数据
  List<double> classData = [];

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
  }

  void collectData() {
    classData = [];
    if (_selectedClass != null && _selectedSubject != null) {
      // 1. 根据已经选择的班级和科目筛选获取所有信息
      List<User> filteredData = responseData
          .where((user) =>
              user.className == _selectedClass &&
              (_selectedSubject == '数学'
                  ? user.mathScore != 0
                  : _selectedSubject == '语文'
                      ? user.chineseScore != 0
                      : user.englishScore != 0))
          .toList();

      // 2. 根据信息条数得到该班级的人数
      double studentCount = filteredData.length as double;
      classData.add(studentCount);

      // 3. 获取该班级该科目的最高分
      int maxScore = filteredData.fold<int>(
          0,
          (max, user) => _selectedSubject == '数学'
              ? user.mathScore > max
                  ? user.mathScore
                  : max
              : _selectedSubject == '语文'
                  ? user.chineseScore > max
                      ? user.chineseScore
                      : max
                  : user.englishScore > max
                      ? user.englishScore
                      : max);
      print(maxScore);
      classData.add(maxScore as double);

      // 4. 获取该班级该科目的最低分
      int minScore = filteredData.fold<int>(
          filteredData.first.mathScore,
          (min, user) => _selectedSubject == '数学'
              ? user.mathScore < min
                  ? user.mathScore
                  : min
              : _selectedSubject == '语文'
                  ? user.chineseScore < min
                      ? user.chineseScore
                      : min
                  : user.englishScore < min
                      ? user.englishScore
                      : min);
      classData.add(minScore as double);

      // 5. 计算该班级选择的该科目的平均成绩
      double totalScore = filteredData.fold<double>(
          0,
          (total, user) => _selectedSubject == '数学'
              ? total + user.mathScore
              : _selectedSubject == '语文'
                  ? total + user.chineseScore
                  : total + user.englishScore);
      double averageScore = totalScore / studentCount;
      classData.add(averageScore);
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/4.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: collectData,
                  child: Text('刷新数据'),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DropdownButton<String>(
                      hint: Text('科目选择'),
                      items: ['三年级1班', '三年级2班', '三年级3班', '三年级4班', '三年级5班']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedClass = newValue;
                        });
                      },
                      value: _selectedClass,
                    ),
                    DropdownButton<String>(
                      hint: Text('科目选择'),
                      items: ['语文', '数学', '英语'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedSubject = newValue;
                        });
                      },
                      value: _selectedSubject,
                    )
                  ],
                ),
                SizedBox(height: 10),
                classData.isNotEmpty
                    ? Container(
                  key: UniqueKey(),
                  width: 370,
                  height: 380,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.tealAccent.withOpacity(0.5),
                      width: 2.0,
                    ),
                  ),
                  child: ClassChart(classData),
                )
                    : SizedBox(),
              ],
            ),
          )
        ],
      ),
    );
  }
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

class Statistics {
  final int studentCount;
  final int maxScore;
  final int minScore;
  final double averageScore;

  Statistics(
      this.studentCount, this.maxScore, this.minScore, this.averageScore);
}
