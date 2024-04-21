import 'package:flutter/material.dart';

import '../score/pie _chart.dart';

class Pie extends StatefulWidget {
  @override
  _PieState createState() => _PieState();
}

class _PieState extends State<Pie> {
  // 用于保存选中的值的变量
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // 设置水平方向居中对齐
                children: [
                  DropdownButton<String>(
                    // 设置下拉菜单按钮的提示文本
                    hint: Text('班级选择'),
                    // 设置下拉菜单中的所有选项
                    items: <String>[
                      '三年级一班',
                      '三年级二班',
                      '三年级三班',
                      '三年级四班',
                      '三年级五班'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    // 当用户选择一个选项时调用的回调函数
                    onChanged: (String? newValue) {
                      // 在用户选择时更新选中的值，并重新构建小部件以更新UI
                      setState(() {
                        _selectedOption = newValue;
                      });
                    },
                    // 设置默认选中的选项
                    value: _selectedOption,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                child: pie(),
              ),
            ],
          ),
        ));
  }
}
