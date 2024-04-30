import 'package:untitled/helper/web_view_module/web_view_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../constants/app.export.dart';

class WebViewClass extends StatelessWidget {
  String? title;
  String? url;

  WebViewClass({this.title, Key? key, this.url}) : super(key: key);

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GetBuilder<WebViewClassController>(
          init: WebViewClassController(url: this.url),
          dispose: (_) => Get.delete<WebViewClassController>(),
          builder: (_) {
            return Scaffold(
              body: mainBody(_, context),
            );
          }),
    );
  }

  mainBody(WebViewClassController _, BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Utils.getSize(0)),
                Padding(
                  padding: EdgeInsets.only(left: Utils.getSize(16), right: Utils.getSize(16), top: Utils.getSize(20)),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Center(
                          child: BaseText(
                        text: title ?? "",
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      )),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(Utils.getSize(8)),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: ColorRes.blackColor,
                            size: Utils.getSize(18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Utils.getSize(14),
                ),
                Expanded(
                  child: url != null
                      ? IndexedStack(
                          index: _.selectedIndex,
                          children: [
                            WebViewWidget(
                              controller: _.controller!,
                            ),
                            Center(
                              child: CircularProgressIndicator(
                                color: ColorRes.primaryColor,
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Utils.getSize(20)),
                          child: BaseText(
                            text: "Oops! Something went wrong",
                            color: ColorRes.blackColor,
                            textAlign: TextAlign.center,
                          ),
                        )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
