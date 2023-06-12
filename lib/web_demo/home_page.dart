import 'package:flutter/material.dart';

import 'web_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("web 左滑返回测试"),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> WebPage()));
          },
          child: Text(
            "进入web",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}