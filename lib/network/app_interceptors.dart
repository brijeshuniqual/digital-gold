import 'dart:async';
import 'package:dio/dio.dart';
import '../common_model/common_response.dart';
import '../constants/app.export.dart';


class AppInterceptors extends Interceptor {
  Function? callback;
  bool? isShowToast;

  AppInterceptors({
    this.callback,
    this.isShowToast,
  });

  @override
  FutureOr<dynamic> onRequest(RequestOptions options, handler) async {
    return handler.next(options);
  }

  @override
  FutureOr<dynamic> onError(DioError err, ErrorInterceptorHandler handler) async {
    print("====== ERROR ======== ${err.toString()}");
    print("====== ERROR ======== ${err.response?.realUri}");
    print("====== ERROR ======== ${err.response?.statusCode}");
    print("====== ERROR ======== ${err.response?.data}");
    if (err.response?.statusCode == 401 || err.toString().contains("401")) {
      debugPrint("IN APP INTERCEPTOR ERROR 401");
      await Utils.performLogout(isFromAppInterceptors: true);
      return null;
    }
    Utils.showCircularProgressLottie(false);
    CommonResponse? commonResponse;
    if(err.response != null) {
      if(isShowToast! && err.response!.data["message"] != null && err.response!.data["message"] != "") Utils.showErrToast(err.response!.data["message"]);
      commonResponse = CommonResponse.fromJson(err.response!.data);
    }
    return commonResponse;
  }

  @override
  FutureOr<dynamic> onResponse(response, ResponseInterceptorHandler handler) async {
    print("==== STATUS CODE IN ON RESPONSE ${response.statusCode}");
    if (response.statusCode == 401) {
      await Utils.performLogout(isFromAppInterceptors: true);
      return null;
    } else {
      return handler.next(response);
    }
  }
}
