import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/tabs/emotions.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TourGuideDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onNextPressed;
  final String buttonText; // 添加新的命名参数

  const TourGuideDialog({
    required this.title,
    required this.message,
    required this.onNextPressed,
    required this.buttonText, // 在构造函数中接收新的命名参数
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(message),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: onNextPressed,
                  child: Text(buttonText), // 使用命名参数的值作为按钮文本
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class oursPage extends StatelessWidget {
  const oursPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("关于我们"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Stack( // 使用Stack布局
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return TourGuideDialog(
                          title: '欢迎使用教师助手!',
                          message: '首页有本年级的一些基础信息。',
                          onNextPressed: () {
                            Navigator.of(context).pop(); // 关闭当前的TourGuideDialog
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return TourGuideDialog(
                                  title: '欢迎使用教师助手!',
                                  message: '个人成绩页面可以查询个人成绩和查看班级的成绩。',
                                  onNextPressed: () {
                                    Navigator.of(context).pop(); // 关闭当前的TourGuideDialog
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return TourGuideDialog(
                                          title: '欢迎使用教师助手!',
                                          message: '班级成绩页面可以查看班级的情况，便签可以记录笔记。',
                                          onNextPressed: () {
                                            Navigator.of(context).pop(); // 关闭当前的TourGuideDialog
                                            // 显示成功提示
                                            Fluttertoast.showToast(
                                              msg: "恭喜完成导航",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.TOP,
                                              timeInSecForIosWeb: 3,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );
                                          },
                                          buttonText: '完成', // 修改按钮文本为“完成”
                                        );
                                      },
                                    );
                                  },
                                  buttonText: '下一步', // 修改按钮文本为“下一步”
                                );
                              },
                            );
                          },
                          buttonText: '下一步', // 修改按钮文本为“下一步”
                        );
                      },
                    );
                  },
                  //onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => emotions()));},
                  child: Text('显示漫游式引导'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}