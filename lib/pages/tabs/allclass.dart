import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../chart/app_colors.dart';

class LineChartSample2 extends StatefulWidget {
  final List<int> allScores;
  const LineChartSample2(this.allScores, {Key? key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  late List<FlSpot> spots;

  //计算优秀占比
  late double excellent;

  //计算较差占比
  late double poor;

  @override
  void initState() {
    super.initState();
    //print(widget.allScores);
    // 调用转换函数，将成绩列表转换为FlSpot对象列表
    spots = convertScoresToSpots(widget.allScores);
    // 1. 筛选出大于等于90的分数
    List<int> highScores = widget.allScores.where((score) => score >= 90).toList();
    // 2. 计算筛选后的数组长度
    int highScoreCount = highScores.length;
    // 3. 计算比例
    excellent = highScoreCount / widget.allScores.length * 100;
    List<int> lowScores = widget.allScores.where((score) => score < 60).toList();
    int lowScoreCount = lowScores.length;
    poor = lowScoreCount / widget.allScores.length * 100;
  }

  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];

  bool showAvg = false;





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("全级成绩分布情况")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1.70,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
          Text("优秀人数（大于90）占比${excellent.toStringAsFixed(2)}%，较差人数（小于60）占比${poor.toStringAsFixed(2)}%",
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 20:
        text = const Text('20', style: style);
        break;
      case 40:
        text = const Text('40', style: style);
        break;
      case 60:
        text = const Text('60', style: style);
        break;
      case 80:
        text = const Text('80', style: style);
        break;
      case 100:
        text = const Text('100', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    return Text('${value.toInt()}0', style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 20,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 4,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 100,
      minY: 0,
      maxY: 15,
      lineBarsData: [
        LineChartBarData(
          spots: spots, // 使用转换后的FlSpot对象列表
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  List<FlSpot> convertScoresToSpots(List<int> scores) {
    // 初始化分数统计数组，长度为11，分别代表0到100每个10分范围内的人数
    List<int> scoreCounts = List<int>.filled(10, 0);

    // 遍历给定的成绩列表，统计每个分数范围内的人数
    for (int score in scores) {
      // 计算该分数在哪个范围内
      int index = (score / 10).floor();
      // 确保分数在有效范围内
      if (index >= 0 && index < 10) {
        scoreCounts[index]++;
      }
    }

    // 构建对应的FlSpot对象列表
    List<FlSpot> spots = [];
    for (int i = 0; i < scoreCounts.length; i++) {
      // 计算该范围的起始位置，例如0-9分对应0，10-19分对应10，以此类推
      double startX = i * 10.toDouble();
      // 添加FlSpot对象，坐标为该范围的中间位置，人数为该范围内的人数
      spots.add(FlSpot(startX + 5, scoreCounts[i].toDouble()));
    }
    spots.add(FlSpot(100, 0));
    //print(spots);

    return spots;
  }
}
