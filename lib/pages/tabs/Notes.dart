import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 定义便签数据结构
class Note {
  final String content;

  Note(this.content);
}

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<Note> notes = [];
  late String _content;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _loadNotes(); // 加载已保存的便签数据
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("便签"),
        backgroundColor: Color.fromARGB(255, 210, 213, 216), // 设置背景色为灰色
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addNote,
          ),
        ],
      ),
      body: _buildNotesList(),
    );
  }

  // 构建便签列表
  Widget _buildNotesList() {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(notes[index].content),
          onTap: () {
            _editNote(index);
          },
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteNote(index);
            },
          ),
        );
      },
    );
  }

  // 添加便签方法
  void _addNote() async {
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('添加便签'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: '内容'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: Text('取消'),
          ),
          TextButton(
            onPressed: () {
              // 添加便签到列表
              setState(() {
                _content = _controller.text;
                notes.add(Note(_content));
              });
              _saveToSharedPreferences(_content); // 保存到SharedPreferences
              Navigator.pop(context, 'OK');
            },
            child: Text('确认'),
          ),
        ],
      ),
    );
    _controller.clear();
  }

  // 将内容保存到SharedPreferences
  void _saveToSharedPreferences(String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedNotes = prefs.getStringList('notes');
    if (savedNotes == null) {
      savedNotes = [];
    }
    savedNotes.add(content);
    await prefs.setStringList('notes', savedNotes);
  }

  // 加载已保存的便签数据
  void _loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedNotes = prefs.getStringList('notes');
    if (savedNotes != null) {
      setState(() {
        notes = savedNotes.map((content) => Note(content)).toList();
      });
    }
  }

  // 删除便签方法
  void _deleteNote(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedNotes = prefs.getStringList('notes');
    if (savedNotes != null) {
      setState(() {
        notes.removeAt(index);
        savedNotes.removeAt(index);
        prefs.setStringList('notes', savedNotes);
      });
    }
  }

  // 修改便签方法
  void _editNote(int index) async {
    _controller.text = notes[index].content;
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('修改便签'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: '内容'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: Text('取消'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _content = _controller.text;
                notes[index] = Note(_content);
              });
              _updateSharedPreferences(index, _content);
              Navigator.pop(context, 'OK');
            },
            child: Text('确认'),
          ),
        ],
      ),
    );
    _controller.clear();
  }

  // 更新便签内容到SharedPreferences
  void _updateSharedPreferences(int index, String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedNotes = prefs.getStringList('notes');
    if (savedNotes != null) {
      savedNotes[index] = content;
      prefs.setStringList('notes', savedNotes);
    }
  }
}
