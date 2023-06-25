import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  String posturl;
   WebViewScreen({super.key,required this.posturl});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:WebView(
              initialUrl:widget.posturl ,
              javascriptMode: JavascriptMode.unrestricted,
              userAgent: "random",
              onWebViewCreated: (WebViewController webViewController){
                _controller.complete(webViewController);
                print("created");
              },
              gestureNavigationEnabled: true,

            )
            ),
      ),
    );
  }
}