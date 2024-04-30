import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../common_model/common_response.dart';
import '../constants/injector.dart';
import '../constants/pref_keys.dart';
import '../constants/utils.dart';
import 'app_interceptors.dart';

class BaseNetwork {
  static const String baseUrl = "https://uniqual.dev:3038/api/v1";

  static Future<CommonResponse> get(String partUrl,
      {Map<String, dynamic>? queryParameters, bool isForLogin = false, bool isShowToast = true, bool isMultiPart = false}) async {
    CommonResponse commonResponse = CommonResponse();
    await Utils.isInternetConnected().then((isConnected) async {
      if (isConnected) {
        debugPrint("URL IN GET ==== ${"$baseUrl/$partUrl"}");
        debugPrint("REQUEST IN GET ==== $queryParameters");
        Dio dio = initDio(partUrl, isMultiPart, isCheckIntercept: isForLogin ? false : true, isShowToast: isShowToast);
        try {
          await dio.get("", queryParameters: queryParameters).then((response) async {
            if (response.statusCode == 401 && !isForLogin) {
              debugPrint("IN GET RESPONSE 401");
              await Utils.performLogout(isFromAppInterceptors: true);
              return null;
            } else {
              if (response.data != null) {
                debugPrint("RESPONSE IN GET ==== $response");
                var temp = response.data["data"];
                if (temp is List) {
                  List<dynamic>? responseModel = response.data["data"];
                  if (responseModel != null && responseModel.isNotEmpty) {
                    commonResponse.listData = [];
                    for (var element in responseModel) {
                      commonResponse.listData?.add(element);
                    }
                  }
                  if (response.data["meta"] != null) {
                    commonResponse.meta = Meta.fromJson(response.data["meta"]);
                    debugPrint("META DATA IN GET ====== ${commonResponse.meta?.toJson()}");
                  }
                  if (response.data["errors"] != null) {
                    commonResponse.errors = Errors.fromJson(response.data["errors"]);
                    debugPrint("ERRORS IN GET ====== ${commonResponse.errors?.toJson()}");
                  }
                  if (response.data["message"] != null) {
                    commonResponse.message = response.data["message"];
                    debugPrint("MESSAGE IN GET ====== ${commonResponse.message}");
                  }
                  if (response.data["status"] != null) {
                    commonResponse.status = response.data["status"];
                    debugPrint("status IN GET ====== ${commonResponse.status}");
                  }
                } else {
                  commonResponse = CommonResponse.fromJson(response.data);
                }
              }
            }
          }).catchError((e) async {
            debugPrint("ERROR IN GET E ${e.toString()}");
            debugPrint("ERROR IN GET E.MESSAGE ${e.message}");
            if (!isForLogin) {
              if (e.message.toString().contains("401")) {
                debugPrint("IN GET ERROR 401");
                await Utils.performLogout(isFromAppInterceptors: true);
                return null;
              }
            }
            if (isShowToast && e.response.data["message"] != null && e.response.data["message"] != "") Utils.showErrToast(e.response.data["message"]);
            commonResponse = CommonResponse.fromJson(e.response.data);
          });
        } catch (e) {
          debugPrint("CATCH IN GET ==== ${e.toString()}");
          if (!isForLogin) {
            if (e.toString().contains("401")) {
              debugPrint("IN GET CATCH ERROR 401");
              await Utils.performLogout(isFromAppInterceptors: true);
              return null;
            }
          }
        }
      } else {
        Utils.showErrToast("Please Check Your Network Connection");
      }
    });
    return commonResponse;
  }

  static Future<CommonResponse> put(String partUrl,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      bool isForLogin = false,
      bool isShowToast = true,
      bool isMultiPart = false}) async {
    CommonResponse commonResponse = CommonResponse();
    debugPrint("URL IN PUT ==== ${"$baseUrl/$partUrl"}");
    debugPrint("REQUEST FOR PUT ======= ----- ${body.toString()}");
    debugPrint("QUERY PARAMETERS FOR PUT ======= ----- ${queryParameters.toString()}");
    await Utils.isInternetConnected().then((isConnected) async {
      if (isConnected) {
        FormData formData = FormData();
        Dio dio = initDio(partUrl, isMultiPart, isCheckIntercept: isForLogin ? false : true, isShowToast: isShowToast);
        if (isMultiPart) {
          formData = FormData.fromMap(body!);
        }
        try {
          await dio.put("", data: isMultiPart ? formData : body, queryParameters: queryParameters).then((response) async {
            if (response.statusCode == 401 && !isForLogin) {
              debugPrint("IN PUT RESPONSE 401");
              await Utils.performLogout(isFromAppInterceptors: true);
              return null;
            } else {
              if (response.data != null) {
                debugPrint("RESPONSE IN PUT ==== $response");
                var temp = response.data["data"];
                if (temp is List) {
                  List<dynamic>? responseModel = response.data["data"];
                  if (responseModel != null && responseModel.isNotEmpty) {
                    commonResponse.listData = [];
                    for (var element in responseModel) {
                      commonResponse.listData?.add(element);
                    }
                  }
                  if (response.data["meta"] != null) {
                    commonResponse.meta = Meta.fromJson(response.data["meta"]);
                    debugPrint("META DATA IN PUT ====== ${commonResponse.meta?.toJson()}");
                  }
                  if (response.data["errors"] != null) {
                    commonResponse.errors = Errors.fromJson(response.data["errors"]);
                    debugPrint("ERRORS IN PUT ====== ${commonResponse.errors?.toJson()}");
                  }
                  if (response.data["message"] != null) {
                    commonResponse.message = response.data["message"];
                    debugPrint("MESSAGE IN PUT ====== ${commonResponse.message}");
                  }
                  if (response.data["status"] != null) {
                    commonResponse.status = response.data["status"];
                    debugPrint("status IN PUT ====== ${commonResponse.status}");
                  }
                } else {
                  commonResponse = CommonResponse.fromJson(response.data);
                }
              }
            }
          }).catchError((e) async {
            debugPrint("ERROR IN PUT E ${e.toString()}");
            debugPrint("ERROR IN PUT E.MESSAGE ${e.message}");
            if (!isForLogin) {
              if (e.message.toString().contains("401")) {
                debugPrint("IN PUT ERROR 401");
                await Utils.performLogout(isFromAppInterceptors: true);
                return null;
              }
            }
            if (isShowToast && e.response.data["message"] != null && e.response.data["message"] != "") Utils.showErrToast(e.response.data["message"]);
            commonResponse = CommonResponse.fromJson(e.response.data);
          });
        } catch (e) {
          debugPrint("CATCH IN PUT ==== ${e.toString()}");
          if (!isForLogin) {
            if (e.toString().contains("401")) {
              debugPrint("IN PUT CATCH ERROR 401");
              await Utils.performLogout(isFromAppInterceptors: true);
              return null;
            }
          }
        }
      } else {
        Utils.showErrToast("Please Check Your Network Connection");
      }
    });
    return commonResponse;
  }

  static Future<CommonResponse?> post(String partUrl,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      bool isForLogin = false,
      bool isShowToast = true,
      bool isMultiPart = false}) async {
    CommonResponse commonResponse = CommonResponse();
    debugPrint("URL IN POST ==== ${"$baseUrl/$partUrl"}");
    debugPrint("REQUEST FOR POST ======= ----- ${body.toString()}");
    debugPrint("QUERY PARAMETERS FOR POST ======= ----- ${queryParameters.toString()}");
    await Utils.isInternetConnected().then((isConnected) async {
      if (isConnected) {
        FormData formData = FormData();
        Dio dio = initDio(partUrl, isMultiPart, isCheckIntercept: isForLogin ? false : true, isShowToast: isShowToast);
        if (isMultiPart) {
          formData = FormData.fromMap(body!);
        }
        try {
          await dio.post("", data: isMultiPart ? formData : body, queryParameters: queryParameters).then((response) async {
            if (response.statusCode == 401 && !isForLogin) {
              debugPrint("IN POST RESPONSE 401");
              await Utils.performLogout(isFromAppInterceptors: true);
              return null;
            } else {
              if (response.data != null) {
                debugPrint("RESPONSE IN POST ==== $response");
                var temp = response.data["data"];
                if (temp is List) {
                  List<dynamic>? responseModel = response.data["data"];
                  if (responseModel != null && responseModel.isNotEmpty) {
                    commonResponse.listData = [];
                    for (var element in responseModel) {
                      commonResponse.listData?.add(element);
                    }
                  }
                  if (response.data["meta"] != null) {
                    commonResponse.meta = Meta.fromJson(response.data["meta"]);
                    debugPrint("META DATA IN POST ====== ${commonResponse.meta?.toJson()}");
                  }
                  if (response.data["errors"] != null) {
                    commonResponse.errors = Errors.fromJson(response.data["errors"]);
                    debugPrint("ERRORS IN POST ====== ${commonResponse.errors?.toJson()}");
                  }
                  if (response.data["message"] != null) {
                    commonResponse.message = response.data["message"];
                    debugPrint("MESSAGE IN POST ====== ${commonResponse.message}");
                  }
                  if (response.data["status"] != null) {
                    commonResponse.status = response.data["status"];
                    debugPrint("status IN POST ====== ${commonResponse.status}");
                  }
                } else {
                  commonResponse = CommonResponse.fromJson(response.data);
                }
              }
            }
          }).catchError((e) async {
            debugPrint("ERROR IN POST E ${e.toString()}");
            debugPrint("ERROR IN POST E.MESSAGE ${e.message}");
            if (!isForLogin) {
              if (e.message.toString().contains("401")) {
                debugPrint("IN POST ERROR 401");
                await Utils.performLogout(isFromAppInterceptors: true);
                return null;
              }
            }
            if (isShowToast && e.response.data["message"] != null && e.response.data["message"] != "") Utils.showErrToast(e.response.data["message"]);
            commonResponse = CommonResponse.fromJson(e.response.data);
          });
        } catch (e) {
          debugPrint("CATCH IN POST ==== ${e.toString()}");
          if (!isForLogin) {
            if (e.toString().contains("401")) {
              debugPrint("IN POST CATCH ERROR 401");
              await Utils.performLogout(isFromAppInterceptors: true);
              return null;
            }
          }
        }
      } else {
        Utils.showErrToast("Please Check Your Network Connection");
      }
    });
    return commonResponse;
  }

  static Dio initDio(String partUrl, bool isMultipart, {bool isCheckIntercept = true, bool isShowToast = true}) {
    var dio = Dio();
    Map<String, String?> headers;
    String acceptHeader;
    String contentTypeHeader;
    String acceptLanguageHeader;

    acceptHeader = 'application/json';
    contentTypeHeader = isMultipart ? 'multipart/form-data' : 'application/json';
    acceptLanguageHeader = Injector.getSelectedLanguage() ?? '';

    headers = {
      'Api-Key': '6888f953-bf61-41f7-9999-d90fe883d691',
      HttpHeaders.acceptLanguageHeader: acceptLanguageHeader,
      HttpHeaders.acceptHeader: acceptHeader,
      HttpHeaders.contentTypeHeader: contentTypeHeader,
      HttpHeaders.authorizationHeader:
          Injector.prefs?.getString(PrefKeys.accessToken) != null ? 'Bearer ${Injector.prefs!.getString(PrefKeys.accessToken)!}' : null
    };
    final fullUrl = "$baseUrl/$partUrl";
    BaseOptions options = BaseOptions(
      baseUrl: fullUrl,
      connectTimeout: const Duration(milliseconds: 20000),
      receiveTimeout: const Duration(milliseconds: 30000),
      headers: headers,
    );

    dio.options = options;
    debugPrint("======== TOKEN IN BASE NETWORK ====== ${Injector.prefs?.getString(PrefKeys.accessToken)}");
    if (isCheckIntercept) {
      dio.interceptors.add(
        AppInterceptors(
            callback: (options, e, handler) async {
              var headers = {
                HttpHeaders.acceptHeader: acceptHeader,
                HttpHeaders.contentTypeHeader: contentTypeHeader,
                HttpHeaders.authorizationHeader:
                    Injector.prefs?.getString(PrefKeys.accessToken) != null ? 'Bearer ${Injector.prefs!.getString(PrefKeys.accessToken)!}' : null
              };
              final opts = Options(method: e.requestOptions.method, headers: headers);
              final response = await dio.request(
                options.path,
                options: opts,
                data: options.data,
                queryParameters: options.queryParameters,
              );
              if (response != null) {
                handler.resolve(response);
              } else {
                return null;
              }
            },
            isShowToast: isShowToast),
      );
      dio.interceptors.add(LogInterceptor());
    }
    return dio;
  }

  static Future<CommonResponse> delete(String partUrl,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      bool isForLogin = false,
      bool isShowToast = true,
      bool isMultiPart = false}) async {
    CommonResponse commonResponse = CommonResponse();
    await Utils.isInternetConnected().then((isConnected) async {
      debugPrint("URL IN DELETE ==== ${"$baseUrl/$partUrl"}");
      debugPrint("QUERY PARAMETERS IN DELETE ==== $queryParameters");
      debugPrint("REQUEST IN DELETE ==== $body");
      if (isConnected) {
        FormData formData = FormData();
        Dio dio = initDio(partUrl, isMultiPart, isCheckIntercept: isForLogin ? false : true, isShowToast: isShowToast);
        if (isMultiPart) {
          formData = FormData.fromMap(body!);
        }
        try {
          await dio.delete("", data: isMultiPart ? formData : body, queryParameters: queryParameters).then((response) async {
            if (response.statusCode == 401 && !isForLogin) {
              debugPrint("IN DELETE RESPONSE 401");
              await Utils.performLogout(isFromAppInterceptors: true);
              return null;
            } else {
              if (response.data != null) {
                debugPrint("RESPONSE IN DELETE ==== $response");
                var temp = response.data["data"];
                if (temp is List) {
                  List<dynamic>? responseModel = response.data["data"];
                  if (responseModel != null && responseModel.isNotEmpty) {
                    commonResponse.listData = [];
                    for (var element in responseModel) {
                      commonResponse.listData?.add(element);
                    }
                  }
                  if (response.data["meta"] != null) {
                    commonResponse.meta = Meta.fromJson(response.data["meta"]);
                    debugPrint("META DATA IN DELETE ====== ${commonResponse.meta?.toJson()}");
                  }
                  if (response.data["errors"] != null) {
                    commonResponse.errors = Errors.fromJson(response.data["errors"]);
                    debugPrint("ERRORS IN DELETE ====== ${commonResponse.errors?.toJson()}");
                  }
                  if (response.data["message"] != null) {
                    commonResponse.message = response.data["message"];
                    debugPrint("MESSAGE IN DELETE ====== ${commonResponse.message}");
                  }
                  if (response.data["status"] != null) {
                    commonResponse.status = response.data["status"];
                    debugPrint("status IN DELETE ====== ${commonResponse.status}");
                  }
                } else {
                  commonResponse = CommonResponse.fromJson(response.data);
                }
              }
            }
          }).catchError((e) async {
            debugPrint("ERROR IN DELETE E ${e.toString()}");
            debugPrint("ERROR IN DELETE E.MESSAGE ${e.message}");
            debugPrint("ERROR IN DELETE E.RESPONSE.DATA ${e.response.data.toString()}");
            if (!isForLogin) {
              if (e.message.toString().contains("401")) {
                debugPrint("IN DELETE ERROR 401");
                await Utils.performLogout(isFromAppInterceptors: true);
                return null;
              }
            }
            if (isShowToast && e.response.data["message"] != null && e.response.data["message"] != "") Utils.showErrToast(e.response.data["message"]);
            commonResponse = CommonResponse.fromJson(e.response.data);
          });
        } catch (e) {
          debugPrint("CATCH IN DELETE ==== ${e.toString()}");
          if (!isForLogin) {
            if (e.toString().contains("401")) {
              debugPrint("IN DELETE ERROR 401");
              await Utils.performLogout(isFromAppInterceptors: true);
              return null;
            }
          }
        }
      } else {
        Utils.showErrToast("Please Check Your Network Connection");
      }
    });

    return commonResponse;
  }
}
