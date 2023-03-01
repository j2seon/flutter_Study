import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebVeiws extends StatelessWidget {
  WebVeiws({Key? key}) : super(key: key);
  WebViewController? controller;
  final homUrl = 'https://blog.codefactory.ai';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appbar'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if(controller == null){
                return ;
              }
              controller!.loadUrl(homUrl);
            },
            icon: Icon(Icons.home),
          ),
        ],
      ),
      body: SafeArea(
        child: WebView(
          onWebViewCreated: (WebViewController controller) {
            this.controller = controller;
          },
          initialUrl: homUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
