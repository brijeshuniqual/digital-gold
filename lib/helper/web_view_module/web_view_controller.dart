import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../constants/app.export.dart';

class WebViewClassController extends GetxController {
  int selectedIndex = 1;
  String? url;
  WebViewController? controller;

  WebViewClassController({this.url});

  @override
  void onInit() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
              selectedIndex = 0;
              update();
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url!));
    super.onInit();
  }

}
