import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnChartPage extends StatefulWidget {
  const ColumnChartPage({super.key});

  @override
  State<ColumnChartPage> createState() => _ColumnChartPageState();
}

class _ColumnChartPageState extends State<ColumnChartPage> {
  @override
  Widget build(BuildContext context) {
    final List<RevenueData> data = [
      RevenueData('CN1', 30),
      RevenueData('CN2', 70),
      RevenueData('CN3', 50),
      RevenueData('CN4', 25),
      RevenueData('CN5', 60),
      RevenueData('CN6', 85),
      RevenueData('CN7', 40),
      RevenueData('CN8', 75),
      RevenueData('CN9', 90),
      RevenueData('CN10', 55),
      RevenueData('CN11', 65),
      RevenueData('CN12', 0),
      RevenueData('CN13', 95),
    ];

    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 350,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: data.length * 80,
              child: SfCartesianChart(
                legend: const Legend(isVisible: true),
                primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(
                    width: 1,
                    color: Color(0xFFECEEF0),
                  ),
                  majorTickLines: const MajorTickLines(size: 0),
                ),
                primaryYAxis: const NumericAxis(
                  interval: 20,
                  minimum: 0,
                  maximum: 100,
                  majorGridLines: MajorGridLines(
                    width: 1,
                    color: Color(0xFFECEEF0),
                  ),
                  axisLine: AxisLine(width: 0),
                  majorTickLines: MajorTickLines(size: 0),
                ),
                series: <CartesianSeries>[
                  ColumnSeries<RevenueData, String>(
                    dataSource: data,
                    xValueMapper: (RevenueData d, _) => d.day,
                    yValueMapper: (RevenueData d, _) => d.value,
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(6),
                    width: 0.6,
                    spacing: 0.3,
                    name: 'Doanh thu',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RevenueData {
  RevenueData(this.day, this.value);

  final String day;
  final double value;
}
