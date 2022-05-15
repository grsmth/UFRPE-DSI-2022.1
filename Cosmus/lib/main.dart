import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CustomerLocation> states = [];
  Future <String> getJsonFromFirebase() async{
    String url = 'https://exampledb-7ca46-default-rtdb.firebaseio.com/data.json';
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }
  Future loadSalesData() async{
    final String jsonString = await getJsonFromFirebase();
    final dynamic jsonResponse = json.decode(jsonString);
    for(Map<String, dynamic> i in jsonResponse){
      states.add(CustomerLocation.fromjson(i));
    }

  }
  @override
  void initState(){
    loadSalesData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold (body: FutureBuilder(future: getJsonFromFirebase(), builder:(context, snapshot){
      if (snapshot.hasData){
        return (SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series: <ChartSeries>[
          LineSeries<CustomerLocation,String>(
          dataSource: states,
          xValueMapper: (CustomerLocation details, _) => details.state,
          yValueMapper: (CustomerLocation details, _) => details.customers)
        ]));
    } else{
        return Center(child: CircularProgressIndicator());
      }
    },
      )));
  }
}
class CustomerLocation{
  CustomerLocation(this.state, this.customers);
  final String state;
  final int customers;
  factory CustomerLocation.fromjson(Map<String, dynamic> parsedJson){
    return CustomerLocation(parsedJson['state'].toString(), parsedJson['customers']);
  }
}