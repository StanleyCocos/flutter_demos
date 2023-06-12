import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("MyApp");
    return ScreenUtilInit(
        designSize: Size(750, 1334),
        builder: (context, child){
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: List(),
          );
        }
    );
  }
}

class List extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListState();
}

class _ListState extends State<List> {
  @override
  Widget build(BuildContext context) {
    print("123");
    return Scaffold(
      appBar: AppBar(
        title: Text("列表"),
      ),
      body: GridView.builder(
        itemCount: 30,
        //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
            crossAxisCount: 3,
            //纵轴间距
            mainAxisSpacing: 20.0,
            //横轴间距
            crossAxisSpacing: 10.0,
            //子组件宽高长度比例
            childAspectRatio: 1.0),
        itemBuilder: (BuildContext context, int index) {
          //Widget Function(BuildContext context, int index)
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ImagePage()));
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.red,
              child: Center(
                child: Text(
                  "测试$index",
                  style: TextStyle(
                    fontSize: 48.sp
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ImagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ImageState();
}

class _ImageState extends State<ImagePage> {

  var images = [
    "https://cp4.100.com.tw/service/2017/06/06/src_149672325950613109.jpg!5413t1000-v5.jpg",
    "https://cp4.100.com.tw/service/2017/06/06/src_149671664960816804.jpg!5413t1000-v5.jpg",
    "https://cp4.100.com.tw/service/2017/06/06/src_149671673896743805.jpg!5413t1000-v5.jpg"
  ];

  @override
  void initState() {
    AutoOrientation.fullAutoMode();
    super.initState();
  }


  @override
  void dispose() {
    AutoOrientation.portraitUpMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片"),
      ),
      body: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(images[index]),
          );
        },
      ),
    );
  }
}
