import 'package:flutter/material.dart';
import 'package:collection/collection.dart'; // 导入 collection 包
import 'package:flutter_application_1/pages/tabs/scorewidget/table.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../service/globals_provider.dart';

class PasswordPage extends StatefulWidget {
  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {

  List<int> selectedNumbers = [];
  late List<int> expectedNumbers;

  void _onGestureTap(int number) {
    setState(() {
      selectedNumbers.add(number);
    });
  }

  void _submitQuestionnaire() {
    // 校验输入的数字序列是否为1到9

    var listEquality = ListEquality<int>(); // 实例化 ListEquality 对象
    if (listEquality.equals(selectedNumbers, expectedNumbers)) {

      // 显示成功提示
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(
      //       '密码正确',
      //       style: TextStyle(color: Colors.green), // 设置文字颜色为绿色
      //     ),
      //     duration: Duration(seconds: 2),
      //   ),
      // );
      Fluttertoast.showToast(
        msg: "密码正确",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => table()),
      );
    } else {
      //显示失败提示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('密码错误，请重新输入'),
          duration: Duration(seconds: 2),
        ),
      );
      // Fluttertoast.showToast(
      //   msg: "密码错误",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.TOP,
      //   timeInSecForIosWeb: 3,
      //   backgroundColor: Colors.deepOrange,
      //   textColor: Colors.white,
      //   fontSize: 16.0,
      // );
    }

    // 清除用户的选择
    setState(() {
      selectedNumbers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    expectedNumbers = Provider.of<GlobalArrayProvider>(context).globalArray;
    // print(globalArray);
    return Scaffold(
      appBar: AppBar(
        title: Text('密码解锁,默认密码是12345'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: selectedNumbers.map((number) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    number.toString(),
                    style: TextStyle(fontSize: 24),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    int number = index + 1;
                    return GestureDetector(
                      onTap: () => _onGestureTap(number),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            number.toString(),
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitQuestionnaire,
        child: Icon(Icons.send),
      ),
    );
  }
}
