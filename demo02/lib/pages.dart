import 'package:flutter/material.dart';
import 'custome_router.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('FirstPage', style: TextStyle(fontSize: 36.0),),
        elevation: 0.0,
      ),
      body: Center(
        child: MaterialButton(
            child: Icon(
              Icons.navigate_next,
              color: Colors.white,
              size: 64.0
            ),
            onPressed: () {
              Navigator.of(context).push(CustomeRoute(SecondPage()));
            },
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        title: Text('SecodPage', style: TextStyle(fontSize: 36.0)),
        backgroundColor: Colors.pinkAccent,
        elevation: 0.0,
        leading: Container(),
      ),
      body: Center(
        child: MaterialButton(
            child: Icon(
              Icons.navigate_before,
              color: Colors.white,
              size: 64.0
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
        ),
      ),
    );
  }
}
