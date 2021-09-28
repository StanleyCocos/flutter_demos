import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Page1(),
    );
  }
}

class Page1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    List<String> tags = [
      '我要好好学习',
      'Java',
      'Object-C',
      'Swiddft',
      'Dart',
      'Pythodadfadfasn',
      'Javascrdddddddddipt'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("tag 测试"),
      ),
      body: Column(
        children: [
          TagView(
            tags: tags,
            backgroundColor: Colors.orange,
            spacing: 20,
            runSpacing: 20,
            padding: EdgeInsets.all(20),
            builder: (context, index) => Container(
              color: Colors.blueGrey,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: Colors.red,
                  ),
                  Text('${tags[index]}'),
                ],
              ),
            ),
            onTap: (text) {
              print(text);
            },
          ),
        ],
      ),
    );
  }
}

/// 点击回调 index
typedef TagItemTap = Function(int index);

/// 快速创建tagView
class TagView extends StatefulWidget {
  /// 内容列表
  final List<String> tags;

  /// margin
  EdgeInsets margin;

  /// padding
  EdgeInsets padding;

  /// tagView背景颜色
  Color backgroundColor;

  /// tag横向间距
  final double spacing;

  /// tag纵向间距
  final double runSpacing;

  /// 点击回调
  final TagItemTap onTap;

  /// 自定义Tag
  IndexedWidgetBuilder builder;

  TagView({
    Key key,
    this.tags,
    this.margin,
    this.padding,
    this.backgroundColor,
    this.runSpacing: 10,
    this.spacing: 10,
    this.onTap,
    this.builder,
  }) : super(key: key) {

    this.padding = this.padding ??
        EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10);
  }

  @override
  _TagViewState createState() => _TagViewState();
}

class _TagViewState extends State<TagView> {
  @override
  Widget build(BuildContext context) {
    if (widget.tags.length == 0 || widget.tags == null) return Container();
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        color: widget.backgroundColor,
        margin: widget.margin,
        padding: widget.padding,
        child: Wrap(
          spacing: widget.spacing,
          runSpacing: widget.runSpacing,
          children: widget.tags.map(
            (res) {
              int i = widget.tags.indexOf(res);
              return GestureDetector(
                onTap: ()=> widget.onTap?.call(i),
                child: widget.builder(context, i),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
