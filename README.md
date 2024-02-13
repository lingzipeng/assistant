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

```
//左图标设置

icon: isSearching ? null : Icon(Icons.search),

//右图标设置

suffixIcon: isSearching ? IconButton(

icon: Icon(Icons.search),

onPressed: () {

},

) : null,
```

