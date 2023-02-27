import 'package:flutter/material.dart';
import 'package:frontend/login.dart';
import 'package:frontend/select_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SelectMode(),
    );
  }
}

