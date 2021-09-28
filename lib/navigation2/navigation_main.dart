import 'package:flutter/material.dart';
import 'package:flutter_demos/navigation2/route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: MyRouteParser(),
      routerDelegate: MyRouteDelegate()..initRotePath(MyRoutePath()),
    );
  }
}