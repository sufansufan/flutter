import 'package:flutter/material.dart';
// import 'expasion_tile_demo.dart';
import 'expansion_panel_list.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      theme: ThemeData.dark(),
      // home: ExpansionTileDemo(),
      home: ExpansionPanelListDemo(),
    );
  }
}
