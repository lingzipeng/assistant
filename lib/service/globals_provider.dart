import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GlobalArrayProvider extends ChangeNotifier {
  List<int> _globalArray = [1, 2, 3, 4, 5];

  List<int> get globalArray => _globalArray;

  set globalArray(List<int> newArray) {
    _globalArray = newArray;
    notifyListeners(); // 通知监听者更新
  }
}