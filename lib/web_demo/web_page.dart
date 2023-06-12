import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WebState();
}

class _WebState extends State<WebPage> {

  bool _canBack = false;



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            title: Text("web 左滑返回测试"),
          ),
          body: WebView(
            initialUrl: 'https://m.debug.8591.com.tw/v3/',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              // _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              print('WebView is loading (progress : $progress%)');
            },
            javascriptChannels: <JavascriptChannel>{
              // _toasterJavascriptChannel(context),
            },
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                print('blocking navigation to $request}');
                return NavigationDecision.prevent;
              }
              print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
            onDidScrollCallback: (double offset) {
              print('onDidScrollCallback: $offset');
            },
            onTitleChangeCallback: (String title) {
              print('onTitleChangeCallback: $title');
            },
            onUrlChangeCallback: (String url) {
              print('onUrlChangeCallback: $url');
            },
            onCanGoBackCallback: (bool canGoBack) {
              print('onCanGoBackCallback：$canGoBack');
              _canBack = canGoBack;
              setState(() {});
            },
            gestureNavigationEnabled: true,
            backgroundColor: const Color(0x00000000),
          )),
      onWillPop: _canBack ? () async {
        return true;
      } : null,
    );
  }
}
