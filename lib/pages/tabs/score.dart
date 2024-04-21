import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/tabs/score/bar_chart.dart';
import 'package:flutter_application_1/pages/tabs/score/pie%20_chart.dart';
import 'package:flutter_application_1/pages/tabs/scorewidget/bar.dart';
import 'package:flutter_application_1/pages/tabs/scorewidget/pie.dart';
import 'package:flutter_application_1/pages/tabs/scorewidget/table.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DataModel(), // 创建数据模型对象
      child: Scaffold(
        body: Center(
          child: Consumer<DataModel>(
            builder: (context, dataModel, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     // 获取 DataModel 实例
                  //     DataModel dataModel = context.read<DataModel>();
                  //
                  //     dataModel.setResponseData('222');
                  //   },
                  //   child: const Text('点击'),
                  // ),
                  // const SizedBox(height: 20),
                  // Text(
                  //   'Response Data: ${dataModel.responseData}',
                  //   style: TextStyle(fontSize: 18),
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => table()),
                      );
                    },
                    //直接搜索，直接出来学生姓名和学生成绩的图形化展示
                    child: Text('学生搜索'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => table()),
                      );
                    },
                    //班级选择    一个班成绩展示
                    child: Text('班级表格'),
                  ),
                  //测试，后面删掉
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Bar()),
                      );
                    },
                    child: Text('柱状图'),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class DataModel extends ChangeNotifier {
  String responseData = '';

  void setResponseData(String data) {
    responseData = data;
    notifyListeners(); // 通知监听器状态已更新
  }
}
