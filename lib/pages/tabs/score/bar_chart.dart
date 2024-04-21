import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        height: 500,
        width: 500,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: PieChart(
              PieChartData(
                // read about it in the PieChartData section
              ),
              swapAnimationDuration: Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear, // Optional
            )
          ),
        ),

    );
  }
}
