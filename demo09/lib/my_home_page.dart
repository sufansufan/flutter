import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('my home page'),),
      body: Center(
        child: Text('首页')
      ),
    );
  }
}
