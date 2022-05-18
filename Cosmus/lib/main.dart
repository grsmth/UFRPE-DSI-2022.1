// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, avoid_unnecessary_containers, unused_import

import 'package:cosmus/telaGrafico.dart';
import 'package:flutter/material.dart';
import 'package:cosmus/bargraph.dart';

void main (){
  runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => TelaPrincipal(),
        '/Screen2': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        '/Screen3': (context) => BarChart(title: 'BarChart')
      },
      debugShowCheckedModeBanner: false
  ));
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({ Key? key }) : super(key: key);

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF525252),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset("images/logo.jpg"),
            ButtonTheme(
              minWidth: 100.0,
              height: 50.0,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BarChart(title: '',))
                );
                },
                child: Text("Gráfico Pagamentos"),
              ),
            ),
            ButtonTheme(
              minWidth: 100.0,
              height: 50.0,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage(title: '',))
                  );
                },
                child: Text("Gráfico Clientes por estado"),
              ),
            )
          ],
        ),
      ),
    );
  }
}