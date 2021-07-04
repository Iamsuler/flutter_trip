import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class WebViewer extends StatefulWidget {
  late final String url;
  final String? statusBarColor;
  final String? title;
  final bool? hideAppBar;
  final bool backForbid;

  WebViewer(
      {Key? key,
      required this.url,
      required this.statusBarColor,
      required this.title,
      required this.hideAppBar,
      this.backForbid = false })
      : super(key: key);

  @override
  _WebViewerState createState() => _WebViewerState();
}

class _WebViewerState extends State<WebViewer> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool isExisting = false;

  @override
  void initState() {
    super.initState();

    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String defaultStatusBarColorStr = 'ffffff';
    String statusBarColorStr =
        widget.statusBarColor ?? defaultStatusBarColorStr;
    Color backButtonColor = statusBarColorStr == defaultStatusBarColorStr
        ? Colors.black
        : Colors.white;
    return Scaffold(
      body: Column(
        children: [
          _appBar(Color(int.parse('0xff$statusBarColorStr')), backButtonColor),
          Expanded(
            child: Builder(
              builder: (context) => WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                onProgress: (int progress) {
                  print("WebView is loading (progress : $progress%)");
                },
                onPageStarted: (String url) {
                  print('Page started loading: $url');
                },
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                },
                onWebResourceError: (WebResourceError error) {
                  print(error);
                },
                navigationDelegate: (NavigationRequest request) {
                  if (_isToMain(request.url) && !isExisting && !widget.backForbid) {
                    print('blocking navigation to $request}');
                    Navigator.pop(context);
                    isExisting = true;
                    return NavigationDecision.prevent;
                  }
                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
                gestureNavigationEnabled: true,
              ),
            )
          )
        ],
      ),
    );
  }

  Widget _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }

    return Container(
      child: FractionallySizedBox(
        child: Stack(
          children: [
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title ?? '',
                  style: TextStyle(fontSize: 20, color: backButtonColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url.endsWith(value)) {
        contain = true;
        break;
      }
    }

    return contain;
  }
}
