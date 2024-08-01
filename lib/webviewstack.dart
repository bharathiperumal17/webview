import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({required this.controller, super.key});
  final WebViewController controller;
  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (navigation) {
          final host = Uri.parse(navigation.url).host;
          if (host.contains('https://www.youtube.com/')) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Blocking navigation to $host',
                ),
              ),
            );
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ),
    );
    widget.controller.loadRequest(
      Uri.parse(
          'https://api.flutter.dev/flutter/rendering/CustomClipper-class.html'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(
          controller: widget.controller,
        ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
          ),
      ],
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// void openApp(BuildContext context, String appName, String appUrl,
//     String playStoreUrl) async {
//   try {
//     if (await launchUrl(Uri.parse(appUrl))) {
//     } else {
//       showDialog(
//         // ignore: use_build_context_synchronously
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('App Not Installed'),
//             content: Text('The $appName app is not installed on your device.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   // Launch Play Store URL
//                   launchUrl(Uri.parse(playStoreUrl));
//                 },
//                 child: const Text('Install from Play Store'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('Cancel'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   } catch (e) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('App Not Installed'),
//           content: Text('The $appName app is not installed on your device.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 // Launch Play Store URL
//                 launchUrl(Uri.parse(playStoreUrl));
//               },
//               child: const Text('Install from Play Store'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

// class WebViewChart extends StatefulWidget {
//   const WebViewChart({super.key, required this.title});

//   final String title;

//   @override
//   State<WebViewChart> createState() => _WebViewChartState();
// }

// class _WebViewChartState extends State<WebViewChart>
//     with TickerProviderStateMixin {
//   WebViewController controller = WebViewController();
//   void controllerUrl(WebViewController controller, BuildContext context) async {
//     await controller.setJavaScriptMode(JavaScriptMode.unrestricted);
//     await controller
//         .loadRequest(Uri.parse('https://taikonz.io/tradeview/BTC_USDT'));
//   }

//   @override
//   void initState() {
//     super.initState();
//     late final PlatformWebViewControllerCreationParams params;
//     if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//       params = WebKitWebViewControllerCreationParams(
//         allowsInlineMediaPlayback: true,
//         mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
//       );
//     } else {
//       params = const PlatformWebViewControllerCreationParams();
//     }
//     controller = WebViewController.fromPlatformCreationParams(params);
//     controllerUrl(controller, context);
//     if (controller.platform is AndroidWebViewController) {
//       AndroidWebViewController.enableDebugging(false);
//       (controller.platform as AndroidWebViewController)
//           .setMediaPlaybackRequiresUserGesture(true);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: WebViewWidget(
//           controller: controller,
//         ),
//       ),
//     );
//   }
// }