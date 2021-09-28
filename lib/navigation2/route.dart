import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demos/navigation2/page.dart';
import 'package:flutter_demos/navigation2/tool.dart';

// class MyRouteParser extends RouteInformationParser<String> {
//   @override
//   Future<String> parseRouteInformation(RouteInformation routeInformation) {
//     showToast("parseRouteInformation: ${routeInformation.location}");
//     print("parseRouteInformation: ${routeInformation.location}");
//     final uri = Uri.parse(routeInformation.location);
//     if(uri.pathSegments.length > 1){
//       return SynchronousFuture(uri.pathSegments[0]);
//     } else {
//       return SynchronousFuture(routeInformation.location);
//     }
//
//   }
//
//   @override
//   RouteInformation restoreRouteInformation(String configuration) {
//     showToast("restoreRouteInformation: ${configuration}");
//     print("restoreRouteInformation: $configuration");
//     return RouteInformation(location: configuration);
//   }
// }
//
// class MyRouteDelegate extends RouterDelegate<String>
//     with PopNavigatorRouterDelegateMixin<String>, ChangeNotifier {
//   MyRouteDelegate._();
//
//   static MyRouteDelegate _instance;
//
//   factory MyRouteDelegate() {
//     if (_instance == null) _instance = MyRouteDelegate._();
//     return _instance;
//   }
//
//   final _stack = <String>[];
//   RoutePath _path;
//
//   void initRotePath(RoutePath path) {
//     _path = path;
//   }
//
//   @override
//   GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//
//   @override
//   String get currentConfiguration {
//     print("currentConfiguration: ${_stack.last}");
//     return _path.getPath(_stack.isNotEmpty ? _stack.last : null);
//   }
//
//   List<String> get stack => List.unmodifiable(_stack);
//
//   Object get arguments => _path.pages.last.arguments;
//
//   void push(Widget page, {Object args}) {
//     print("push");
//     _stack.add(page.runtimeType.toString());
//     _path.pages.add(MyPage(
//       name: page.runtimeType.toString(),
//       page: page,
//       arguments: args,
//     ));
//     notifyListeners();
//   }
//
//   void pop() {
//     print("pop");
//     _stack.removeLast();
//     _path.pages.removeLast();
//     notifyListeners();
//   }
//
//
//   @override
//   Future<void> setNewRoutePath(String configuration) {
//     print("setNewRoutePath: $configuration");
//     if (configuration == "/") {
//       _stack.clear();
//       _path.pages.clear();
//     }
//     showToast("setNewRoutePath: $configuration");
//
//     _stack.add(_path.getPath(configuration));
//     Widget page = _path.getPage(configuration);
//     _path.pages.add(MyPage(
//       name: page.runtimeType.toString(),
//       page: page,
//     ));
//
//     return SynchronousFuture<void>(null);
//   }
//
//   bool _onPopPage(Route<dynamic> route, dynamic result) {
//     print("_onPopPage");
//     if (_stack.isNotEmpty) {
//       if (_stack.last == route.settings.name) {
//         _stack.remove(route.settings.name);
//         _path.pages.removeLast();
//         notifyListeners();
//       }
//     }
//     return route.didPop(result);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print("build");
//     List<Page> list = [];
//     _path.pages.forEach(
//           (element) {
//         list.add(
//           element,
//         );
//       },
//     );
//
//     return Navigator(
//       key: navigatorKey,
//       onPopPage: _onPopPage,
//       pages: list,
//     );
//   }
// }




class MyRouteParser extends RouteInformationParser<PathConfig> {

  MyRoutePath _path = MyRoutePath();

  @override
  Future<PathConfig> parseRouteInformation(RouteInformation routeInformation)  {
    showToast("parseRouteInformation: ${routeInformation.location}");
    print("parseRouteInformation: ${routeInformation.location}");
    final uri = Uri.parse(routeInformation.location);
    print("parseRouteInformation: ${uri.pathSegments}");
    if(uri.pathSegments.length > 1){
      return SynchronousFuture(PathConfig(name: uri.pathSegments[0], args: uri.pathSegments[1])) ;
    } else if(uri.pathSegments.length > 0){
      return SynchronousFuture(PathConfig(name: uri.pathSegments[0]));
    } else {
      return SynchronousFuture(PathConfig(name: routeInformation.location));
    }

  }

  @override
  RouteInformation restoreRouteInformation(PathConfig configuration) {
    showToast("restoreRouteInformation: ${configuration.name}");
    print("restoreRouteInformation: ${configuration.name}");
    switch(configuration.state){
      case PathState.Detail:
        return RouteInformation(location: "${_path.getPath(configuration.name)}/${configuration.args}");
      default:
        return RouteInformation(location: "${_path.getPath(configuration.name)}");
    }
  }
}

class MyRouteDelegate extends RouterDelegate<PathConfig>
    with PopNavigatorRouterDelegateMixin<PathConfig>, ChangeNotifier {
  MyRouteDelegate._();

  static MyRouteDelegate _instance;

  factory MyRouteDelegate() {
    if (_instance == null) _instance = MyRouteDelegate._();
    return _instance;
  }

  final _stack = <PathConfig>[];
  RoutePath _path;

  void initRotePath(RoutePath path) {
    _path = path;
  }

  @override
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  PathConfig get currentConfiguration {
    print("currentConfiguration: ${_stack.last.name}");
    return _stack.isNotEmpty ? _stack.last : null;
    // return _path.getPath(_stack.isNotEmpty ? _stack.last : null);
  }

  List<String> get stack => List.unmodifiable(_stack);

  Object get arguments => _path.pages.last.arguments;

  void push(Widget page, {Object args, bool replace = false}) {
    print("push");
    if(replace){
      _stack.last = PathConfig(name: page.runtimeType.toString(), args: args);
      _path.pages.last = MyPage(
        key: ValueKey(page.runtimeType.toString()),
        name: page.runtimeType.toString(),
        page: page,
        arguments: args,
      );
    } else {
      _stack.add(PathConfig(name: page.runtimeType.toString(), args: args));
      _path.pages.add(MyPage(
        key: ValueKey(page.runtimeType.toString()),
        name: page.runtimeType.toString(),
        page: page,
        arguments: args,
      ));
    }


    notifyListeners();
  }

  void pop() {
    print("pop");
    _stack.removeLast();
    _path.pages.removeLast();
    notifyListeners();
  }


  void switchPage(String path){
    _stack.last = PathConfig(name: path);
    notifyListeners();
  }


  @override
  Future<void> setNewRoutePath(PathConfig configuration) {
    print("setNewRoutePath: ${configuration.name}");
    if (configuration.name == "/") {
      _stack.clear();
      _path.pages.clear();
    }
    showToast("setNewRoutePath: ${configuration.name}");

    _stack.add(configuration);
    Widget page = _path.getPage(configuration.name);
    _path.pages.add(MyPage(
      key: ValueKey(configuration.name),
      name: page.runtimeType.toString(),
      page: page,
      arguments: configuration.args
    ));

    return SynchronousFuture<void>(null);
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    print("_onPopPage");
    if (_stack.isNotEmpty) {
      _stack.removeLast();
      _path.pages.removeLast();
      notifyListeners();
    }
    return route.didPop(result);
  }

  @override
  Widget build(BuildContext context) {
    print("build: ${_path.pages.length}");
    List<Page> list = [];
    _path.pages.forEach(
          (element) {
            print(element.name);
        list.add(
          element,
        );
      },
    );

    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopPage,
      pages: list,
    );
  }
}



class MyPage extends Page {
  final Widget page;

  const MyPage({
    LocalKey key,
    String name,
    Object arguments,
    this.page,
  }) : super(
          key: key,
          name: name,
          arguments: arguments,
        );

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => page,
    );
  }
}

abstract class RoutePath {
  Widget get root;

  Map<String, String> routeName;

  List<Page> pages = [];

  Widget getPage(String path);

  String getPath(String path) {
    var route = path;
    if (routeName.containsKey(path)) {
      route = routeName[path];
    } else if (routeName.containsValue(path)) {
      for (var key in routeName.keys) {
        if (path == routeName[key]) {
          route = key;
          break;
        }
      }
    }
    return route;
  }
}

class MyRoutePath extends RoutePath {

  @override
  Widget get root {
    return WelcomePage();
  }

  @override
  Map<String, String> get routeName => {
        "ad-start": "AdStartPage",
        "home": "TabPage",
        "work-detail": "WorkDetail",
        "image-detail": "ImageDetail",
      };

  @override
  Widget getPage(String path) {
    switch (path) {
      case "/":
        return root;
      case "ad-start":
        return AdStartPage();
      case "home":
        return TabPage();
      case "work-detail":
        return WorkDetail();
      case "image-detail":
        return ImageDetail();
    }
    return root;
  }
}


class PathConfig {

  final String name;
  final Object args;
  PathState state;
  PathConfig({this.name, this.args = ""}){
   if(name == "work-detail" || name == "WorkDetail"){
     state = PathState.Detail;
   } else {
     state = PathState.Home;
   }
  }
}


enum PathState {
  Home,
  Detail,
  NotFound,
}
