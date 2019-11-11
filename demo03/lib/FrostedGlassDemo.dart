import 'package:flutter/material.dart';
import 'dart:ui';  //使用顾虑器

class FrostedGlassDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( //重叠组件
        children: <Widget>[
          ConstrainedBox( //约束盒子，添加额外的约束条件再child上
            constraints: const BoxConstraints.expand(),
            child: Image.network('http://pic37.nipic.com/20140113/8800276_184927469000_2.png'),
          ),
          Center(
            child: ClipRect( //可裁切矩形
              child: BackdropFilter( //背景过滤器
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Opacity(
                  opacity: 0.3,
                  child: Container(
                    width: 500.0,
                    height: 700.0,
                    decoration: BoxDecoration(color: Colors.grey.shade200), //盒子修饰器
                    child: Center(
                      child: Text(
                        'sufan',
                        style: Theme.of(context).textTheme.display3,
                      ),
                    ),
                  ),
                )
              )
            ),
          ),
        ]
      ),
    );
  }
}
