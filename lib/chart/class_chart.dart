import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class ClassChart extends StatefulWidget {
  final List<double> classData;
  const ClassChart(this.classData, {super.key});


  @override
  State<ClassChart> createState() => _ClassChartState();
}

class _ClassChartState extends State<ClassChart> {
  final shadowColor = const Color(0xFFCCCCCC);

  late List<_BarData> dataList;
  @override
  void initState() {
    super.initState();
    dataList = [
      _BarData(AppColors.contentColorYellow, widget.classData[0], 18),
      _BarData(AppColors.contentColorBlue, widget.classData[1], 8),
      _BarData(AppColors.contentColorOrange, widget.classData[2], 15),
      _BarData(AppColors.contentColorPink, widget.classData[3], 5),
    ];
  }

  BarChartGroupData generateBarGroup(
      int x,
      Color color,
      double value,
      double shadowValue,
      ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 20,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {  },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.contentColorYellow), // 设置背景颜色为蓝色
                ),
                child: Text("人数${widget.classData[0]}",style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () {  },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.contentColorBlue), // 设置背景颜色为蓝色
                ),
                child: Text("最高分${widget.classData[1]}",style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () {  },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.contentColorOrange), // 设置背景颜色为蓝色
                ),
                child: Text("最低分${widget.classData[2]}",style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () {  },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.contentColorPink), // 设置背景颜色为蓝色
                ),
                child: Text("平均分${widget.classData[3]}",style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: AspectRatio(
            aspectRatio: 1.4,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                borderData: FlBorderData(
                  show: true,
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: AppColors.borderColor.withOpacity(0.2),
                    ),
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: AxisTitles(
                    drawBelowEverything: true,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        return const Text("");
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: _IconWidget(
                            color: dataList[index].color,
                            isSelected: touchedGroupIndex == index,
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppColors.borderColor.withOpacity(0.2),
                    strokeWidth: 1,
                  ),
                ),
                barGroups: dataList.asMap().entries.map((e) {
                  final index = e.key;
                  final data = e.value;
                  return generateBarGroup(
                    index,
                    data.color,
                    data.value,
                    data.shadowValue,
                  );
                }).toList(),
                maxY: 300,
                barTouchData: BarTouchData(
                  enabled: true,
                  handleBuiltInTouches: false,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => Colors.transparent,
                    tooltipMargin: 0,
                    getTooltipItem: (
                        BarChartGroupData group,
                        int groupIndex,
                        BarChartRodData rod,
                        int rodIndex,
                        ) {
                      return BarTooltipItem(
                        rod.toY.toString(),
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          color: rod.color,
                          fontSize: 18,
                          shadows: const [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 12,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  touchCallback: (event, response) {
                    if (event.isInterestedForInteractions &&
                        response != null &&
                        response.spot != null) {
                      setState(() {
                        touchedGroupIndex = response.spot!.touchedBarGroupIndex;
                      });
                    } else {
                      setState(() {
                        touchedGroupIndex = -1;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _BarData {
  const _BarData(this.color, this.value, this.shadowValue);

  final Color color;
  final double value;
  final double shadowValue;
}

class _IconWidget extends ImplicitlyAnimatedWidget {
  const _IconWidget({
    required this.color,
    required this.isSelected,
  }) : super(duration: const Duration(milliseconds: 300));
  final Color color;
  final bool isSelected;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _IconWidgetState();
}

class _IconWidgetState extends AnimatedWidgetBaseState<_IconWidget> {
  Tween<double>? _rotationTween;

  @override
  Widget build(BuildContext context) {
    final rotation = math.pi * 4 * _rotationTween!.evaluate(animation);
    final scale = 1 + _rotationTween!.evaluate(animation) * 0.5;
    return Transform(
      transform: Matrix4.rotationZ(rotation).scaled(scale, scale),
      origin: const Offset(14, 14),
      child: Icon(
        widget.isSelected ? Icons.face_retouching_natural : Icons.face,
        color: widget.color,
        size: 28,
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _rotationTween = visitor(
      _rotationTween,
      widget.isSelected ? 1.0 : 0.0,
          (dynamic value) => Tween<double>(
        begin: value as double,
        end: widget.isSelected ? 1.0 : 0.0,
      ),
    ) as Tween<double>?;
  }
}


