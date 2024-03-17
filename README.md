# 成绩分析小助手

## 前言

目前完成登录功能、便签功能；

搜索功能正在进行中….

## 登录

![image-20240213122548064](C:/Users/lingzipeng/AppData/Roaming/Typora/typora-user-images/image-20240213122548064.png)



TextEditingController是一个控制文本字段内容的控制器。通过它，你可以监听文本字段的变化、获取或设置文本内容，以及执行其他与文本字段相关的操作。

```
// 控制输入框的内容，获取输入账号和密码

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
```

采用Column布局

隐藏输入的代码:obscureText: true,

```
// 获取输入的用户名和密码

String enteredUsername = _usernameController.text;

String enteredPassword = _passwordController.text;
```

```
 Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);//跳转
```

异常时，弹出显示对话框showDialog提示用户

## 便签

![image-20240213122612634](C:/Users/lingzipeng/AppData/Roaming/Typora/typora-user-images/image-20240213122612634.png)



```
// 定义便签数据结构

class Note {

 final String content;

 Note(this.content);

}
```

在 StatefulWidget 的初始化阶段执行了一些必要的操作，包括加载便签数据和初始化文本输入框控制器。这有助于确保 Widget 在构建和显示之前具有必要的数据和状态。

```
 @override

 void initState() {

  super.initState();

  _loadNotes(); // 加载已保存的便签数据

  _controller = TextEditingController();

 }
```

`itemBuilder` 是一个回调函数，用于构建每个列表项的外观和行为。

`itemCount 告诉 ListView.builder` 要构建多少个列表项。

使用了 `setState` 方法来更新 StatefulWidget 的状态。在 Flutter 中，使用 `setState` 方法可以通知框架重新构建 Widget，并更新界面以反映最新的状态变化。

总体实现了一个简单的便签应用，用户可以添加、编辑和删除便签，并且使用 SharedPreferences 来持久化保存便签数据。

## 搜索



![image-20240213122626453](C:/Users/lingzipeng/AppData/Roaming/Typora/typora-user-images/image-20240213122626453.png)

```
bool _isSearching = false;//定义搜索状态
```

用Expanded占据剩余空间的

```dart
//左图标设置

icon: isSearching ? null : Icon(Icons.search),

//右图标设置

suffixIcon: isSearching ? IconButton(

icon: Icon(Icons.search),

onPressed: () {

},

) : null,
```

## 计数器实现

![image](https://github.com/lingzipeng/assistant/blob/main/assets/pic/Snipaste_2024-03-16_14-31-20.png)

## 网络库dio的使用

```dart
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Source Page'),
      ),
      body: Center(
          child: ElevatedButton(
            onPressed: () async {
              // 创建 Dio 实例
              Dio dio = Dio();

              try {
                // 发起 GET 请求
                Response response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');

                // 打印响应数据
                print('Response: ${response.data['title']}');
              } catch (e) {
                print('Error: $e');
              }
            },
            child: Text('Make Network Request'),
          ),
        ),
    );
  }
```



## 状态管理provider的使用

```dart
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
```

## **消息组件**

```dart
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("消息组件"),
    );
  }
}
```

## 轮播图组件

```dart
import 'package:flutter/material.dart';
import '../../component/card_swiper_widget.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final List<String> imageUrls = [
    'https://i0.hdslb.com/bfs/archive/1db01c0402fcb4f55ae96017b0f9986ebee219f0.jpg',
    'https://i0.hdslb.com/bfs/archive/3a1feb2169c236c67b86f8b231a2471780703c4b.jpg@672w_378h_1c_!web-home-common-cover',
    'https://i0.hdslb.com/bfs/archive/f148be797fee7936cd18304a53fafe99860fc5d1.jpg@672w_378h_1c_!web-home-common-cover',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Swiper Example'),
      ),
      body: CardSwiperWidget(imageUrls: imageUrls),
    );
  }
}
```

```dart
//card_swiper_widget.dart
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class CardSwiperWidget extends StatelessWidget {
  final List<String> imageUrls;

  const CardSwiperWidget({Key? key, required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // 设置轮播图高度
      child: Swiper(
        itemCount: imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(
              imageUrls[index],
              fit: BoxFit.cover,
            ),
          );
        },
        pagination: SwiperPagination(), // 添加默认的分页指示器
      ),
    );
  }
}
```

## 曲线图及饼状图

```dart
//echart.dart
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SalesData {
  final int year;
  final int sales;

  SalesData(this.year, this.sales);
}

class LineChartWidget extends StatelessWidget {
  final List<SalesData> data;

  const LineChartWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<SalesData, int>> series = [
      charts.Series(
        id: 'Sales',
        data: data,
        domainFn: (SalesData sales, _) => sales.year,
        measureFn: (SalesData sales, _) => sales.sales,
      )
    ];

    return charts.LineChart(
      series,
      animate: true,
      defaultRenderer: charts.LineRendererConfig(includePoints: true),
      behaviors: [
        charts.ChartTitle('Year',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        charts.ChartTitle('Sales',
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
      ],
    );
  }
}
```

```dart
import 'package:flutter/material.dart';
import '../../component/charts.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final List<SalesData> data = [
    SalesData(1, 100),
    SalesData(2, 150),
    SalesData(3, 200),
    SalesData(4, 180),
    SalesData(5, 250),
    SalesData(6, 300),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line Chart Example'),
      ),
      body: Center(
        child: LineChartWidget(data: data),
      ),
    );
  }
}
```

## 聊天区

```dart
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('教师信息'),
        ),
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: const [
            ChatMessage(
              message: 'Hello everyone!',
              isTeacherMessage: false,
            ),
            SizedBox(height: 20),
            ChatMessage(
              message: 'Hello class, how are you today?',
              isTeacherMessage: true,
            ),
            SizedBox(height: 20),
            ChatMessage(
              message: 'I hope you are all doing well.',
              isTeacherMessage: false,
            ),
            SizedBox(height: 20),
            ChatMessage(
              message: 'Don\'t forget about the upcoming assignment.',
              isTeacherMessage: true,
            ),
          ],
        ));
  }
}

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isTeacherMessage;

  const ChatMessage({
    Key? key,
    required this.message,
    required this.isTeacherMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: isTeacherMessage ? Colors.blue[100] : Colors.green[100],
      child: Text(
        message,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}

```

