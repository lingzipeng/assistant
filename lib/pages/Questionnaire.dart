import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../service/api_service.dart';
import 'package:getwidget/getwidget.dart';

class QuestionnairePage extends StatefulWidget {
  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  late PageController _pageController;
  List<String> _cardList = [
    "Card 1",
    "Card 2",
    "Card 3",
  ];


  List<double> _rating = [];
  List<String?> _name = [];
  List<String?> _remark = [];

  void fetchData() async {
    try {
      Response response = await APIInvestigationService.fetchData();
      List<dynamic> data = response.data['result'];
      setState(() {
        for (var item in data) {
          _name.add(item['name']);
          _remark.add(item['remarks']);
          _rating.add(item['rating']);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    _pageController = PageController(viewportFraction: 0.8);

  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('调查问卷'),
      ),
      body: _name.isEmpty || _rating.isEmpty || _remark.isEmpty
          ? Center(
        child: CircularProgressIndicator(), // 或者其他的加载指示器
      )
          : PageView.builder(
        controller: _pageController,
        itemCount: _name.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/4.jpg'),
                        radius: 30,
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _name[index] ?? "***",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          GFRating(
                            value: _rating[index] ?? 0,
                            onChanged: (double rating) {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 26.0),
                  Text(
                    _remark[index] ?? '***',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
