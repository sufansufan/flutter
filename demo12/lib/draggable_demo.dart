import 'package:flutter/material.dart';
import 'draggable_widget.dart';

class DraggableDemo extends StatefulWidget {
  _DraggableDemoState createState() => _DraggableDemoState();
}

class _DraggableDemoState extends State<DraggableDemo> {
  Color _draggableColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DraggableWidget(offset: Offset(80.0, 80.0), widgetColor: Colors.tealAccent,),
          DraggableWidget(offset: Offset(180.0, 80.0), widgetColor: Colors.redAccent,),
          Center(
            child: DragTarget(
              onAccept: (Color color) {
                _draggableColor = color;
              },
              builder: (context,candidateData,rejecteData){
                return Container(
                  width: 200.0,
                  height: 200.0,
                  color: _draggableColor,
                );
              },
            ),
          )
        ],
      )
    );
  }
}
