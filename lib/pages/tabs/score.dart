import 'package:flutter/material.dart';
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
        appBar: AppBar(
          title: Text('Source Page'),
        ),
        body: Center(
          child: Consumer<DataModel>(
            builder: (context, dataModel, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // 获取 DataModel 实例
                      DataModel dataModel = context.read<DataModel>();

                      dataModel.setResponseData('222');
                    },
                    child: Text('点击'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Response Data: ${dataModel.responseData}',
                    style: TextStyle(fontSize: 18),
                  ),
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