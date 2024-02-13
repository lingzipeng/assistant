import 'package:flutter/material.dart'; // 由于使用了AppBar，需要引入material包

class oursPage extends StatefulWidget {
  const oursPage({Key? key}) : super(key: key);

  @override
  State<oursPage> createState() => _oursPageState();
}

class _oursPageState extends State<oursPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( // 使用Scaffold组件
      appBar: AppBar( // 定义AppBar
        title: Text("关于我们"), // 设置标题
        leading: IconButton( // 在左上角放置一个IconButton
          icon: Icon(Icons.arrow_back), // 使用带有回退箭头的图标
          onPressed: () {
            Navigator.of(context).pop(); // 执行回退操作
          },
        ),
      ),
      body: const Center( // 页面内容仍然放置在Center组件中
        child: Text(
          "更多内容敬请期待",
        ),
      ),
    );
  }
}
