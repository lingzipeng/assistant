import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../chart/student_chart.dart';
import '../../../service/api_service.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
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

class _SearchState extends State<Search> {
  TextEditingController _controller = TextEditingController();
  late List<User> responseData;

  //获取姓名
  List<String> names = [];

  //成绩
  List<int> scores = [];

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
        names = [];
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
            names.add(studentData['name'] ?? '');
          }
        });
        //print(responseData[10].name);
        //print(names);
      });
    } catch (e) {
      setState(() {
        responseData = [];
        names = []; // 在错误情况下，返回空列表
      });
    }
  }

  List<User> searchResults(String query) {
    // 根据查询字符串筛选匹配的用户
    return responseData.where((user) => user.name.contains(query)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  hintText: '搜索学生...',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // 处理搜索操作
                      String query = _controller.text;
                      scores.clear();
                      if(query.isNotEmpty){
                        final user = searchResults(query);
                        if(user.isNotEmpty){
                          scores.add(user[0].chineseScore);
                          scores.add(user[0].mathScore);
                          scores.add(user[0].englishScore);
                        }
                        setState(() {
                        });
                      }
                      print(scores);
                      //print(user);
                      //print('Searching for: $query');
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 80), // 调整间距
              scores.isEmpty ? Center(
                child: Text("请输入真实姓名...",
                  style: TextStyle(
                  color: Colors.purple, // 修改为你想要的颜色
                  fontSize: 28, // 修改为你想要的字体大小
                ),),
              ) : Container(
                key: UniqueKey(),
                width: 370,
                height: 380,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.tealAccent.withOpacity(0.5),
                    width: 2.0,
                  ),
                ),
                child: StudentChart(scores),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
