import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class pie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 500,
        width: 500,
        child: Echarts(
          option: '''
        {
          tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b}: {c} ({d}%)'
          },
          legend: {
            orient: 'vertical',
            left: 10,
            data: ['A', 'B', 'C', 'D', 'E']
          },
          series: [
            {
              name: 'Pie Chart',
              type: 'pie',
              radius: ['50%', '70%'],
              avoidLabelOverlap: false,
              label: {
                show: false,
                position: 'center'
              },
              emphasis: {
                label: {
                  show: true,
                  fontSize: '30',
                  fontWeight: 'bold'
                }
              },
              labelLine: {
                show: false
              },
              data: [
                {value: 335, name: 'A'},
                {value: 310, name: 'B'},
                {value: 234, name: 'C'},
                {value: 135, name: 'D'},
                {value: 1548, name: 'E'}
              ]
            }
          ]
        }
      ''',
        ));
  }
}
