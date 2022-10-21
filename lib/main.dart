import 'package:flutter/material.dart';
import 'package:visit_me/pages/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visit-Me',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const RegisterPage(),
    );
  }
}