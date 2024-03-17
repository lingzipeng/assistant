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

