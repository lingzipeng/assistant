import 'package:flutter/material.dart';

class sheet extends StatelessWidget {
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
                child: Container(
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
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('123')),
                          DataCell(Text('张三')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('250')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('124')),
                          DataCell(Text('李四')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('250')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('125')),
                          DataCell(Text('王五')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('250')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('125')),
                          DataCell(Text('王五')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('250')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('125')),
                          DataCell(Text('王五')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('250')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('125')),
                          DataCell(Text('王五')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('250')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('125')),
                          DataCell(Text('王五')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('250')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('125')),
                          DataCell(Text('王五')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('250')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('125')),
                          DataCell(Text('王五')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('250')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('125')),
                          DataCell(Text('王五')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('250')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('125')),
                          DataCell(Text('王五')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('250')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('125')),
                          DataCell(Text('王五')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('250')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('125')),
                          DataCell(Text('王五')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('250')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('126')),
                          DataCell(Text('王五')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('250')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('126')),
                          DataCell(Text('王五')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('250')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('126')),
                          DataCell(Text('王五')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('250')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('127')),
                          DataCell(Text('王五')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('88')),
                          DataCell(Text('250')),
                        ],
                      ),
                    ],
                  ),
                ))));
  }
}
