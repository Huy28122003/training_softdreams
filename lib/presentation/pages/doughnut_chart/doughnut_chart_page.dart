import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughnutChartPage extends StatefulWidget {
  const DoughnutChartPage({super.key});

  @override
  State<DoughnutChartPage> createState() => _DoughnutChartPageState();
}

class _DoughnutChartPageState extends State<DoughnutChartPage> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('David', 25, Color(0xFF00A236)),
      ChartData('Steve', 38, Color(0xFFE65100)),
      ChartData('Jack', 34, Color(0xFF0074BD)),
      ChartData('John', 34, Color(0xFF00743D)),
      ChartData('Others', 52, Color(0xFFB0B0B0))
    ];
    return Scaffold(
      backgroundColor: Color(0xFFF4F6F8),
      body: Center(
        child: SfCircularChart(
          annotations: <CircularChartAnnotation>[
            CircularChartAnnotation(
              widget: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 6.8,
                      offset: Offset(0, 0),
                    )
                  ],
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                margin: EdgeInsets.all(10),
                width: 147,
                height: 147,
              ),
            ),
            CircularChartAnnotation(
              widget: const Text(
                '62%',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            )
          ],
          series: <CircularSeries>[
            DoughnutSeries<ChartData, String>(
              dataSource: chartData,
              pointColorMapper: (ChartData data, _) => data.color,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              radius: '100%',
              strokeWidth: 8,
              strokeColor: Color(0xFFF4F6F8),
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                labelPosition: ChartDataLabelPosition.inside,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
