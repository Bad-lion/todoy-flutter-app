import 'package:flutter/material.dart';
import 'view/task_body.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskBody(),
    );
  }
}
