import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SalesData {
  final int year;
  final int sales;

  SalesData(this.year, this.sales);
}

class LineChartWidget extends StatelessWidget {
  final List<SalesData> data;

  const LineChartWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<SalesData, int>> series = [
      charts.Series(
        id: 'Sales',
        data: data,
        domainFn: (SalesData sales, _) => sales.year,
        measureFn: (SalesData sales, _) => sales.sales,
      )
    ];

    return charts.LineChart(
      series,
      animate: true,
      defaultRenderer: charts.LineRendererConfig(includePoints: true),
      behaviors: [
        charts.ChartTitle('Year',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        charts.ChartTitle('Sales',
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
      ],
    );
  }
}
