import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './routers/routers.dart';
import './service/globals_provider.dart'; // 导入全局Provider

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 

 const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
 @override
 Widget build(BuildContext context) {
   return MultiProvider(
     providers: [
       ChangeNotifierProvider(create: (_) => GlobalArrayProvider()), // 使用全局Provider
       // 在这里可以添加其他的Provider
     ],
     child: MaterialApp(
       debugShowCheckedModeBanner: false,
       title: '基尼钛镁',
       theme: ThemeData(
         primarySwatch: Colors.blue,
         appBarTheme: const AppBarTheme(
           centerTitle: true,
         ),
       ),
       initialRoute: "/",
       onGenerateRoute: onGenerateRoute, // 假设你已经在routes.dart中定义了onGenerateRoute函数
     ),
   );
 }
}