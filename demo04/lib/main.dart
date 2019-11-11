import 'package:flutter/material.dart';
import 'keep_alive_demo.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue
      ),
      home: KeepAliveDemo(),
    );
  }
}

class KeepAliveDemo extends StatefulWidget {
  _KeepAliveDemoState createState() => _KeepAliveDemoState();
}
class _KeepAliveDemoState extends State<KeepAliveDemo> with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this); // 垂直  使用vsync 必须使用SingleTickerProviderStateMixin  with 是dart中的关键字 意思混入的意思 就是实说可以将一些或者多个类的功能添加到自己的类无需继承这些类 SingleTickerProviderStateMixin 主要是我们初始化TabController时，需要用到vsync ，垂直属性，然后传递this
  }
  @override
  void dispose() {
    _controller.dispose(); //重写销毁方法
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('keep alive demo'),
        bottom: TabBar(
          controller: _controller,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.directions_car),),
            Tab(icon: Icon(Icons.directions_bus),),
            Tab(icon: Icon(Icons.directions_bike),),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          MyHomePage(),
          MyHomePage(),
          MyHomePage(),
        ],
      ),
    );
  }
}
