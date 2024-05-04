import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/tabs/scorewidget/search.dart';
import 'package:flutter_application_1/pages/tabs/scorewidget/table.dart';
import 'package:provider/provider.dart';

import '../Questionnaire.dart';
import '../password.dart';

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
        body: Stack(
          children: [
            Image.asset(
              'assets/images/4.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Consumer<DataModel>(
                builder: (context, dataModel, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Search()),
                          );
                        },
                        //直接搜索，直接出来学生姓名和学生成绩的图形化展示
                        child: Text('学生搜索'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PasswordPage()),
                          );
                        },
                        //班级选择    一个班成绩展示
                        child: Text('成绩表格'),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
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
