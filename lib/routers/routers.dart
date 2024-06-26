import 'package:flutter/cupertino.dart';
import '../pages/ai.dart';
import '../pages/password.dart';
import '../pages/setting.dart';
import 'login.dart'; // 导入登录页面
import '../pages/tabs.dart';
import '../pages/ours.dart';
import '../pages/Questionnaire.dart';


// 1、配置路由
Map<String, WidgetBuilder> routes = {
  "/": (context) =>  const Tabs(), 
  "/ai": (context) => const Ai(),
  "/ours": (context) => const oursPage(),
  "/setting": (context) => settingPage(),
  "/Questionnaire": (context) =>QuestionnairePage(), // 新增登录页面路由
};

// 2、配置onGenerateRoute
var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function? pageContentBuilder = routes[name];

  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = CupertinoPageRoute(
        builder: (context) => pageContentBuilder(context, arguments: settings.arguments),
      );
      return route;
    } else {
      final Route route = CupertinoPageRoute(
        builder: (context) => pageContentBuilder(context),
      );
      return route;
    }
  } 
};


