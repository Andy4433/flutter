import 'package:chuva_dart/screens/calendario.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text("'Chuva ❤️ Flutter'"),
            centerTitle: true,
            backgroundColor: Colors.blue,
          ),
          body: const Caledario(),
          backgroundColor: Colors.white,
        )
    );
  }
}