import 'package:flutter/material.dart';
void main() => runApp(MyApp());

enum ConferenceItem {AddMember, LockConfercence, ModifyLayout, TurnoffAll}
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'popupMenuButton示例',
      home: Scaffold(
        appBar: AppBar(
          title: Text('popupMenuButton示例'),
        ),
        body: Center(
            child: Container(
              height: 300.0,
              width: 200.0,
              child: PopupMenuButton<ConferenceItem>(
              onSelected: (ConferenceItem result) {
                print(result);
              },
              itemBuilder: (BuildContext context) {
                  <PopupMenuEntry<ConferenceItem>>[
                    const PopupMenuItem<ConferenceItem>(
                      value: ConferenceItem.AddMember,
                      child: Text('添加成员'),
                    ),
                    const PopupMenuItem<ConferenceItem>(
                      value: ConferenceItem.LockConfercence,
                      child: Text('锁定会议'),
                    ),
                    const PopupMenuItem<ConferenceItem>(
                      value: ConferenceItem.ModifyLayout,
                      child: Text('修改布局'),
                    ),
                    const PopupMenuItem<ConferenceItem>(
                      value: ConferenceItem.TurnoffAll,
                      child: Text('挂断所有'),
                    )
                  ];
                },
              ),
            )
        ),
      ),
    );
  }
}
