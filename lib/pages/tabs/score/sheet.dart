import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/tabs/scorewidget/table.dart';

class Sheet extends StatelessWidget {
  final List<User>? groupedData;

  const Sheet(this.groupedData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('所有成绩'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: <DataColumn>[
              DataColumn(
                label: Text(
                  '学号',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  '学生姓名',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  '语文',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  '数学',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  '英语',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  '总分',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
            rows: groupedData?.map((user) => DataRow(
              cells: <DataCell>[
                DataCell(Text(user.stuno)),
                DataCell(Text(user.name)),
                DataCell(Text(user.chineseScore.toString())),
                DataCell(Text(user.mathScore.toString())),
                DataCell(Text(user.englishScore.toString())),
                DataCell(Text((user.chineseScore + user.mathScore + user.englishScore).toString())),
              ],
            )).toList() ?? [],
          ),
        ),
      ),
    );
  }
}
