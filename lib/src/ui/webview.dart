import 'package:flutter/material.dart';
import 'package:randomapp/main.dart';

import 'package:webview_flutter/webview_flutter.dart';

///
/// 必須在ios/Runner/Info.plist 加上
/// 	<key>io.flutter.embedded_views_preview</key>
///   <string>YES</string>
///
class WebViewWidget extends StatefulWidget {
  WebViewWidget({
    Key key,
    this.title,
    this.url,
  }) : super(key: key);

  final String title;
  final String url;

  @override
  WebViewState createState() => WebViewState();
}

class WebViewState extends State<WebViewWidget> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: widget.title),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: widget.url,
            onPageFinished: (_) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
          _isLoading ? Center(child: CircularProgressIndicator()) : Container(),
        ],
      ),
    );
  }
}
