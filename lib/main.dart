import 'package:chuva_dart/screens/calendario.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => 
  runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(      
        primarySwatch: Colors.blue,
      ),
      home: 
       Scaffold(
      appBar: AppBar(
        title: const Text('Chuva'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body:  Caledario(),
      backgroundColor: Colors.white,
    )


    );
  }
}

