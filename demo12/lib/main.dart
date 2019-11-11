import 'package:flutter/material.dart';
import './draggable_demo.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      theme: ThemeData.light(),
      home: DraggableDemo(),
    );
  }
}
