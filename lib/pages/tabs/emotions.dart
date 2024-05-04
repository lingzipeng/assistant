import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'allclass.dart';

class emotions extends StatefulWidget {
  final String s;
  final int Rank;
  final int score;
  final List<int> allScores;
  emotions(this.s,this.Rank, this.score, this.allScores, {super.key});

  @override
  _emotionsState createState() => _emotionsState();
}

class _emotionsState extends State<emotions> {
  late String s;
  late double progress;
  late String progressText;
  late int Rank;
  @override
  void initState() {
    super.initState();
    s = widget.s;
    progress = widget.score as double;
    progressText = '${widget.score}';
    Rank = widget.Rank;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Circle Progress Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 300,
                  width: 300,
                  child: CircularProgressIndicator(
                    value: progress / 100,
                    strokeWidth: 20,
                    color: progress>=90?Colors.green:progress<60?Colors.red:Colors.blue,
                  ),
                ),
                Text(
                  progressText,
                  style: TextStyle(fontSize: 50, color: Colors.black),
                ),
                Positioned(
                  bottom: 0,
                  child: Icon(
                    progress>=60?Icons.sentiment_satisfied_alt_outlined:Icons.sentiment_dissatisfied_outlined,
                    size: 130, // 设置图标大小为30
                    color: progress>=90?Colors.green:progress<60?Colors.red:Colors.blue,
                  )
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "学生${widget.s}成绩${progress>=90?"优秀":progress<60?"较差":"一般"}，级排名为",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
                Text(
                  "${widget.Rank}",
                  style: TextStyle(fontSize: 50, color: Colors.red),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LineChartSample2(widget.allScores)));
              },
              child: Text('全级情况'),
            ),
          ],
        ),
      ),
    );
  }
}