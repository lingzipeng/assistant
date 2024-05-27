import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Ai extends StatefulWidget {
  const Ai({Key? key}) : super(key: key);

  @override
  State<Ai> createState() => _AiState();
}

class _AiState extends State<Ai> {
  String _inputText = '';
  String _result = '等待结果...';

  Future<void> _fetchData(String inputText) async {
    try {
      var dio = Dio();
      final response = await dio.get('http://127.0.0.1:5000/hello?message=$inputText');
      if (response.statusCode == 200) {
        setState(() {
          _result = response.data.toString();
        });
      } else {
        setState(() {
          _result = "错误：${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _result = "无法加载数据：$e";
        print(_result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI帮你看'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (text) {
              setState(() {
                _inputText = text+"(350字以内)";
              });
            },
            decoration: InputDecoration(
              hintText: '请输入文本',
              contentPadding: EdgeInsets.all(16.0),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _fetchData(_inputText);
            },
            child: Text('发送'),
          ),
          SizedBox(height: 20),
          Text(_result),
        ],
      ),
    );
  }
}