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
                    ))
              ],
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.people),
              ),
              title: Text("关于我们"),
              onTap: () {
                Navigator.pushNamed(context, '/ours');
              },
            ),
            const Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.find_in_page),
              ),
              title: Text("问卷调查"),
              onTap: () {
                Navigator.pushNamed(context, '/Questionnaire');
              },
            ),
            const Divider(),
            ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.login),
              ),
              title: const Text("退出登录"),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            const Divider(),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.red, //选中的颜色
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
            BottomNavigationBarItem(icon: Icon(Icons.scoreboard_outlined), label: "成绩"),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: "消息"),
            BottomNavigationBarItem(icon: Icon(Icons.note_add), label: "便签"),
          ]),
    );
  }
}
