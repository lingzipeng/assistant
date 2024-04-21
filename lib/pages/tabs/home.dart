import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../chart/home_chart.dart';
import '../../service/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  List<String> names = ['学生个数', '班级个数', '教师人数', '课程门数'];
  List<String> count = ['100个', '5个', '56个', '3个'];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(4, (index) {
                return Center(
                  child: GridItem(names[index], count[index]),
                );
              }),
            ),
            HomeEcharts(),
          ],
        ),
      ),
    );
  }
}

class HomeEcharts extends StatelessWidget {
  const HomeEcharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      height: 380,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.tealAccent.withOpacity(0.5),
          width: 2.0,
        ),
      ),
      child: HomeChart(),
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
