import 'package:app/ui/pages/Applications.dart';
import 'package:app/ui/pages/Companies.dart';
import 'package:app/ui/pages/Home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pagina Pricipal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        "/": (context) => Home(),
        "/companies": (context) => Companies(),
        "/applications": (context) => Applications(),
      },
    );
  }
}
