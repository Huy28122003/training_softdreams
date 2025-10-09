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
    ];

    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 350,
          child: SfCartesianChart(
            // title: const ChartTitle(text: 'Doanh thu'),
            legend: const Legend(isVisible: true),
            primaryXAxis: CategoryAxis(
              majorGridLines: MajorGridLines(
                width: 1,
                color: Color(0xFFECEEF0),
                // dashArray: <double>[4, 4],// nét đứt cho đường doc
              ),
              majorTickLines: MajorTickLines(size: 0),
            ),
            primaryYAxis: const NumericAxis(
              interval: 20,
              minimum: 0,
              maximum: 100,
              majorGridLines: MajorGridLines(
                width: 1,
                color: Color(0xFFECEEF0),
                // dashArray: <double>[4, 4], // nét đứt cho đường ngang
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
                width: 0.8,
                spacing: 0.2,
                name: 'Doanh thu',
              ),
            ],
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
