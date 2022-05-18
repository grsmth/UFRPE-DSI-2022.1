import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BarChart(title: 'Bar graph'),
    );
  }
}

class BarChart extends StatefulWidget {
  const BarChart({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  List<paymentMethods> methods = [];

  dynamic getColumnData(){
    List<paymentMethods> columnData= <paymentMethods>[
      paymentMethods('credit card',76795),
      paymentMethods('boleto',19784),
      paymentMethods('voucher',5775),
      paymentMethods('debit card',1529),
      paymentMethods('not defined',3)
    ];
    return columnData;
  }
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Back'),
        ),
      body:
          SfCartesianChart(
          primaryXAxis: CategoryAxis() ,
          primaryYAxis: NumericAxis() ,
          series: <ChartSeries> [ColumnSeries<paymentMethods,String>(dataSource: getColumnData(),
              xValueMapper: (paymentMethods paym,_) => paym.method,
              yValueMapper: (paymentMethods freq,_) => freq.frequency)],
        )
        );
  }
}
class paymentMethods{
  final String method;
  final int frequency;
  paymentMethods(this.method, this.frequency);
}
