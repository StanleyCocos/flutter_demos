import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demos/navigation2/route.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("welcome"),
      ),
      body: Center(
        child: GestureDetector(
          child: Text("欢迎页"),
          onTap: () {
            MyRouteDelegate().push(AdStartPage(), replace: true);
          },
        ),
      ),
    );
  }
}

class AdStartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdStartState();
}

class _AdStartState extends State<AdStartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("广告"),
      ),
      body: Center(
        child: GestureDetector(
          child: Text("广告页"),
          onTap: () {
            MyRouteDelegate().push(TabPage(), replace: true);
          },
        ),
      ),
    );
  }
}

class TabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabState();
}

class _TabState extends State<TabPage> {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                HomePage(),
                WorkPage(),
                ImagePage(),
                UserPage(),
              ],
            ),
          ),
          tab,
        ],
      ),
    );
  }

  Widget get tab {
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          item("首页", 0),
          item("作品", 1),
          item("图片", 2),
          item("用户", 3),
        ],
      ),
    );
  }

  Widget item(String text, int index) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          var path = "";
          switch(index){
            case 0:
              path = "home";
              break;
            case 1:
              path = "work-list";
              break;
            case 2:
              path = "image-list";
              break;
              case 3:
              path = "user";
              break;
          }

          MyRouteDelegate().switchPage(path);
          _pageController.jumpToPage(index);
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(fontSize: 22, color: Colors.red),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: Center(
        child: Text("首页列表"),
      ),
    );
  }
}

class WorkPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WorkState();
}

class _WorkState extends State<WorkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("作品"),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              width: double.infinity,
              height: 50,
              child: Text("这是第$index个"),
            ),
            onTap: (){
              MyRouteDelegate().push(WorkDetail(), args: "$index");
            },
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片"),
      ),
      body: Center(
        child: Text("图片列表"),
      ),
    );
  }
}

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserState();
}

class _UserState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户"),
      ),
      body: Center(
        child: Text("用户中心"),
      ),
    );
  }
}

class WorkDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WorkDetailState();
}

class _WorkDetailState extends State<WorkDetail> {

  String id = "";

  @override
  void initState() {
    id = MyRouteDelegate().arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("作品详情"),
      ),
      body: Center(
        child: GestureDetector(
          child: Text("作品$id详情"),
          onTap: (){
            MyRouteDelegate().push(ImageDetail());
          },
        ),
      ),
    );
  }
}

class ImageDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片详情"),
      ),
      body: Center(
        child: Text("图片详情"),
      ),
    );
  }
}

class Page1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Page1State();
}

class Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("page1"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.amber,
        child: Center(
          child: TextButton(
            child: Text("进入"),
            onPressed: () {
              MyRouteDelegate().push(Page2());
            },
          ),
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Page2State();
}

class Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("page2"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.amber,
        child: Center(
          child: TextButton(
            child: Text("进入"),
            onPressed: () {
              MyRouteDelegate().push(Page3());
            },
          ),
        ),
      ),
    );
  }
}

class Page3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Page3State();
}

class Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("page3"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.amber,
        child: Text("最后一个页面"),
      ),
    );
  }
}
