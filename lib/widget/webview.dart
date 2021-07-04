import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// ignore: prefer_collection_literals
final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      }),
].toSet();

class WebView extends StatefulWidget {
  late final String url;
  final String? statusBarColor;
  final String? title;
  final bool? hideAppBar;
  final bool? backForbid;

  WebView(
      {Key? key,
      required this.url,
      required this.statusBarColor,
      required this.title,
      required this.hideAppBar,
      this.backForbid})
      : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final webViewReference = FlutterWebviewPlugin();
  late StreamSubscription<String> _onUrlChanged;
  late StreamSubscription<WebViewStateChanged> _onStateChanged;
  late StreamSubscription<WebViewHttpError> _onHttpError;
  // late StreamSubscription<double> _onProgressChanged;
  late StreamSubscription<Null> _onDestroy;

  @override
  void initState() {
    super.initState();

    webViewReference.close();
    _onUrlChanged = webViewReference.onUrlChanged.listen((String url) {
      print('url: $url');
    });
    _onStateChanged =
        webViewReference.onStateChanged.listen((WebViewStateChanged state) {
      print('state.type: ${state.type}');
    });
    _onHttpError =
        webViewReference.onHttpError.listen((WebViewHttpError error) {
      print(error);
    });
    // _onProgressChanged = webViewReference.onProgressChanged.listen((double progress) {
    //   print('progress: $progress');
    // });
    _onDestroy = webViewReference.onDestroy.listen((_) {
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    print('dispose');
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    // _onProgressChanged.cancel();
    _onDestroy.cancel();
    webViewReference.dispose();

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
              child:  WebviewScaffold(
                url: 'https://m.liuxue86.com/sitemap.html',
                appBar: new AppBar(
                  title: const Text('Widget webview'),
                ),
                withZoom: true,
                withLocalStorage: true,
                hidden: true,
                initialChild: Container(
                  color: Colors.redAccent,
                  child: const Center(
                    child: Text('Waiting.....'),
                  ),
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
}
