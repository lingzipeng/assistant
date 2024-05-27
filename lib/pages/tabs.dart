import 'package:flutter/material.dart';
import './tabs/home.dart';
import 'tabs/score.dart';
import './tabs/message.dart';
import 'tabs/Notes.dart';


class Tabs extends StatefulWidget {
  final int index;
  const Tabs({super.key, this.index = 0});
  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  late int _currentIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = widget.index;
  }

  final List<Widget> _pages = const [
    HomePage(),
    CategoryPage(),
    MessagePage(),
    UserPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("成绩分析小助手")),
      drawer: Drawer(
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(
                    flex: 1,
                    child: UserAccountsDrawerHeader(
                      accountName: Text("基尼钛镁"),
                      accountEmail: Text("jinitaimei@qq.com"),
                      decoration: BoxDecoration(
                        color: Colors.blue, // 设置背景颜色为蓝色
                      ),
                    ))
              ],
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.people,color: Colors.blue,),
              ),
              title: Text("关于我们"),
              onTap: () {
                Navigator.pushNamed(context, '/ours');
              },
            ),
            const Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.people,color: Colors.blue,),
              ),
              title: Text("调查问卷"),
              onTap: () {
                Navigator.pushNamed(context, '/Questionnaire');
              },
            ),
            const Divider(),
            // ListTile(
            //   leading: CircleAvatar(
            //     child: Icon(Icons.people,color: Colors.blue,),
            //   ),
            //   title: Text("密码设置"),
            //   onTap: () {
            //     Navigator.pushNamed(context, '/setting');
            //   },
            // ),
            // const Divider(),
            // ListTile(
            //   leading: const CircleAvatar(
            //     child: Icon(Icons.login,color: Colors.blue),
            //   ),
            //   title: const Text("ai帮你看"),
            //   onTap: () {
            //     Navigator.pushNamed(context, '/ai');
            //   },
            // ),
            // const Divider(),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.lightBlue, //选中的颜色
          // iconSize:35,           //底部菜单大小
          currentIndex: _currentIndex, //第几个菜单选中
          type: BottomNavigationBarType.fixed, //如果底部有4个或者4个以上的菜单的时候就需要配置这个参数
          onTap: (index) {
            //点击菜单触发的方法
            //注意
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
            BottomNavigationBarItem(icon: Icon(Icons.scoreboard_outlined), label: "个人成绩"),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: "ai帮你看"),
            BottomNavigationBarItem(icon: Icon(Icons.note_add), label: "便签"),
          ]),
    );
  }
}
