import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart'

class ProblemWebView extends StatelessWidget {
  final String title;
  final String selectedUrl;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  ProblemWebView({
    @required this.title,
    @required this.selectedUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: WebView(
          initialUrl: selectedUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
    // return WebviewScaffold(
    //     url: selectedUrl,
    //     withJavascript: true,
    //     withZoom: true,
    //     appBar: AppBar(
    //       title: Text(title),
    //     ));
  }
}
