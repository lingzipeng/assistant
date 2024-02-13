import 'package:flutter/material.dart';

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({super.key});

  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( // 使用Scaffold组件
      appBar: AppBar( // 定义AppBar
        title: Text("问卷调查"), // 设置标题
        leading: IconButton( // 在左上角放置一个IconButton
          icon: Icon(Icons.arrow_back), // 使用带有回退箭头的图标
          onPressed: () {
            Navigator.of(context).pop(); // 执行回退操作
          },
        ),
      ),
      body: const Center( // 页面内容仍然放置在Center组件中
        child: Text(
          "问卷调查",
        ),
      ),
    );
  }
}
