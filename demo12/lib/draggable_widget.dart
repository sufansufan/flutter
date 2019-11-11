import 'package:flutter/material.dart';

class DraggableWidget extends StatefulWidget {
  final Offset offset;
  final Color widgetColor;
  const DraggableWidget({Key key,this.offset, this.widgetColor}): super(key : key);
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  Offset offset = Offset(0.0, 0.0);
  @override
  void initState() {
    super.initState();
    offset = widget.offset;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: Draggable(
        data: widget.widgetColor,
        child: Container(
          width: 100.0,
          height: 100.0,
          color: widget.widgetColor
        ),
        // 拖拽的时候的样式
        feedback: Container(
          width: 180.0,
          height: 180.0,
          color: widget.widgetColor.withOpacity(0.5),
        ),
        // 松手的样式
        onDraggableCanceled: (Velocity velocity, Offset offset) {
          setState(() {
           this.offset = offset;
          });
        },
      ),
    );
  }
}
