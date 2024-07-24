import 'package:flutter/material.dart';
import 'package:webview/menuoptions.dart';
import 'package:webview/navigationcontroller.dart';
import 'package:webview/webviewstack.dart';
import 'package:webview_flutter/webview_flutter.dart';  

void main() {
  runApp(
    const MaterialApp(
      home: WebViewApp(),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  // Add from here...
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://flutter.dev'),
      );
  }
  // ...to here.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView'),
        actions: [
          NavigationControls(controller: controller),
         Menu(controller: controller),   
        ],
      ),
      body: WebViewStack(controller: controller),       
    );
  }
}