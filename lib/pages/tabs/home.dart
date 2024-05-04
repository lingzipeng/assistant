import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../chart/home_chart.dart';
import '../../service/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage> {
  int studentNums = 0;
  int classNums = 0;
  int teacherNums = 0;
  int courseNums = 0;
  Map<String, double> subjectScores = {
    '语文': 0,
    '数学': 0,
    '英语': 0,
    '总分': 0,
  };
  List<double> averageScores = []; // 存储平均成绩的列表

  @override
  bool get wantKeepAlive => true; // 返回true以保持页面状态

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      Response response = await APIHomeService.fetchData();
      Map<String, dynamic> data = response.data['result'];
      List<dynamic> averageData =
      data['scores']['barEchartsSeriesList'][0]['data'];

      setState(() {
        averageScores =
            averageData.map<double>((value) => value.toDouble()).toList();
        studentNums = data['studentNums'];
        classNums = data['classNums'];
        teacherNums = data['teacherNums'];
        courseNums = data['courseNums'];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // 调用父类的build方法

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/4.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: [
                    GridItem('学生个数', '$studentNums 个'),
                    GridItem('班级个数', '$classNums 个'),
                    GridItem('教师人数', '$teacherNums 人'),
                    GridItem('课程门数', '$courseNums 门'),
                  ],
                ),
                Text("年级平均分"),
                Visibility(visible: averageScores.isNotEmpty,child: averageScores.isNotEmpty
                    ? Container(
                  width: 370,
                  height: 380,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.tealAccent.withOpacity(0.5),
                      width: 2.0,
                    ),
                  ),
                  child: HomeChart(averageScores),
                )
                    : SizedBox()),

              ],
            ),
          )
        ],
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String name;
  final String count;

  GridItem(this.name, this.count);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        border: Border.all(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.all(8.0),
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$count',
                style: TextStyle(color: Colors.white, fontSize: 40.0),
              ),
              Text(
                '$name',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ],
          )),
    );
  }
}
