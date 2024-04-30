import 'dart:io';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:untitled/constants/constant.dart';
import 'package:untitled/main.dart';
import 'package:untitled/screens/intro_module/intro_3_view.dart';
import 'package:untitled/screens/login_module/login_view.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app.export.dart';

class Utils {
  static final ImagePicker _picker = ImagePicker();

  static double getScreenWidth(BuildContext context) {
    return Get.width;
  }

  static double getScreenHeight(BuildContext context) {
    return Get.height;
  }

  static getAssetsImg(String name) {
    return "assets/images/$name.png";
  }

  static getAssetsSVGImg(String name) {
    return "assets/images/$name.svg";
  }

  static getLogoImage(BuildContext context) {
    return Image.asset(
      getAssetsImg("ic_logo"),
      height: getScreenHeight(context) * 0.3,
      width: getScreenWidth(context),
    );
  }

  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  static dynamic getSize(double px) {
    if (Utils.key.currentState != null) {
      return px * (Get.width / 414);
    } else {
      return px;
    }
  }

  static dynamic getFontSize(double px) {
    if (Utils.key.currentState != null) {
      return px * (Get.width / 414) + 2;
    } else {
      return px;
    }
  }

  static launchWhatsapp(String phoneNumber) async {
    // var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
    // var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    var whatsappAndroid = Uri.parse("whatsapp://send?phone=$phoneNumber&text=hello");
    if (await launchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      Utils.showErrToast("WhatsApp is not installed on the device");
    }
  }

  static launchWebsite(String website) async {
    if (await canLaunchUrl(Uri.parse(website))) {
      await launchUrl(Uri.parse(website)).catchError((e) {
        Utils.showErrToast("Sorry, Something went wrong");
        return false;
      });
    } else {
      Utils.showErrToast("Sorry, Something went wrong");
    }
  }

  static launchCall(String phoneNumber) async {
    var phoneUrl = Uri.parse("tel:$phoneNumber}");
    if (await launchUrl(phoneUrl)) {
      await launchUrl(phoneUrl);
    } else {
      Utils.showErrToast("Sorry, Something went wrong");
    }
  }

  static launchMailApp(String email) async {
    String subject = "Subject";
    String desc = "This is App";
    var emailAndroid = Uri.parse("mailto:$email?subject=$subject&body=$desc");
    if (await launchUrl(emailAndroid)) {
      await launchUrl(emailAndroid);
    } else {
      Utils.showErrToast("Sorry, Something went wrong");
    }
  }

  static Future<bool> isInternetConnected() async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (kDebugMode) {
          print("Internet Connected");
        }
        isConnected = true;
      }
    } on SocketException catch (_) {
      if (kDebugMode) {
        print("Internet Not Connected");
      }
      isConnected = false;
    }
    return isConnected;
  }

  static hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static showToast(String? message) {
    if (message != null && message != "") {
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorRes.blackColor,
          textColor: Colors.white);
    }
  }

  static showInfoToast(String? message) {
    if (message != null && message != "") {
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white);
    }
  }

  static showErrToast(String? message, {BuildContext? context}) {
    if (message != null && message != "") {
      // Get.showSnackbar(
      //   GetSnackBar(
      //     title: message,
      //     duration: const Duration(seconds: 2),
      //     titleText: BaseText(
      //       text: message,
      //       fontSize: 18,
      //       fontWeight: FontWeight.w800,
      //       color: ColorRes.whiteColor,
      //     ),
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: ColorRes.redColor,
      //     borderColor: ColorRes.redColor,
      //     borderRadius: Utils.getSize(8),
      //     messageText: const SizedBox(),
      //     animationDuration: const Duration(milliseconds: 300),
      //     padding: const EdgeInsets.only(top: 16, bottom: 10, right: 16, left: 16),
      //     icon: Icon(Icons.info, color: ColorRes.whiteColor),
      //     margin: EdgeInsets.symmetric(horizontal: Utils.getSize(16), vertical: Utils.getSize(30)),
      //   ),
      // );
      Widget toast = Container(
        padding: const EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 16),
        // margin: EdgeInsets.symmetric(horizontal: Utils.getSize(16), vertical: Utils.getSize(30)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Utils.getSize(8)),
          border: Border.all(
            color: ColorRes.redColor,
          ),
          color: ColorRes.redColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.info, color: ColorRes.whiteColor),
            SizedBox(
              width: Utils.getSize(10),
            ),
            Expanded(
              child: BaseText(
                text: message,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: ColorRes.whiteColor,
                maxLines: 4,
              ),
            ),
          ],
        ),
      );
      FToast().init(navigatorKey.currentContext!).showToast(
            child: toast,
            toastDuration: const Duration(seconds: 2),
          );
      // Fluttertoast.showToast(
      //     msg: message,
      //     toastLength: Toast.LENGTH_SHORT,
      //     timeInSecForIosWeb: 3,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.redAccent,
      //     textColor: Colors.white);
    }
  }

  static showSuccessToast(String? message, {BuildContext? context}) {
    if (message != null && message != "") {
      // Get.showSnackbar(GetSnackBar(
      //   title: message,
      //   duration: const Duration(seconds: 2),
      //   titleText: BaseText(
      //     text: message,
      //     fontSize: 18,
      //     fontWeight: FontWeight.w800,
      //     color: Colors.white,
      //   ),
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: Colors.green,
      //   borderColor: Colors.green,
      //   animationDuration: const Duration(milliseconds: 300),
      //   borderRadius: Utils.getSize(8),
      //   messageText: const SizedBox(),
      //   padding: const EdgeInsets.only(top: 16, bottom: 10, right: 16, left: 16),
      //   icon: const Icon(
      //     Icons.check,
      //     color: Colors.white,
      //   ),
      //   margin: EdgeInsets.symmetric(horizontal: Utils.getSize(16), vertical: Utils.getSize(30)),
      // ));
      Widget toast = Container(
        padding: const EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 16),
        // margin: EdgeInsets.symmetric(horizontal: Utils.getSize(16), vertical: Utils.getSize(30)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Utils.getSize(8)),
          border: Border.all(
            color: Colors.green,
          ),
          color: Colors.green,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.check, color: Colors.white),
            SizedBox(
              width: Utils.getSize(10),
            ),
            Expanded(
              child: BaseText(
                text: message,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: ColorRes.whiteColor,
                maxLines: 4,
              ),
            ),
          ],
        ),
      );
      FToast().init(navigatorKey.currentContext!).showToast(
            child: toast,
            toastDuration: const Duration(seconds: 2),
          );
      // if (message != null && message != "") {
      //   Fluttertoast.showToast(
      //       msg: message,
      //       toastLength: Toast.LENGTH_SHORT,
      //       timeInSecForIosWeb: 3,
      //       gravity: ToastGravity.BOTTOM,
      //       backgroundColor: Colors.green,
      //       textColor: Colors.white);
    }
  }

  static showNormalToast(String? message) {
    if (message != null && message != "") {
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white);
    }
  }

  static bool validatePassword(String value) {
    String pattern = r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,30}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static bool validateName(String value) {
    //Alphanumeric characters
    String pattern = r'^[A-Za-z][A-Za-z0-9]*$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static bool? validateEmail(String value) {
    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    // return regExp.hasMatch(value) ? null : "Enter valid email.";
    return regExp.hasMatch(value);
  }

  static String? validateMobileNumber(String value) {
    // String pattern = r'^[0-9]{10}$';
    // RegExp regExp = new RegExp(pattern);
    // return regExp.hasMatch(value) ? null : "Enter valid mobile number.";

    if (value.length != 10) {
      return 'Mobile Number must be of 10 digit';
    } else {
      return null;
    }
  }

  static showCircularProgressLottie(bool isLoading) {
    AlertDialog dialog = AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      elevation: 0.0,
      content: Container(
          height: 60.0,
          color: Colors.transparent,
          child: Center(
            child: Lottie.asset('assets/lottie/loader.json'),
          ),),
    );
    if (!isLoading) {
      Get.back();
    } else {
      Get.dialog(dialog, barrierDismissible: false);
    }
  }

  static Widget applyShadow({double? left, double? right, Widget? child}) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(left: left ?? 30, right: right ?? 30, bottom: 13),
      child: Material(
          shadowColor: ColorRes.blackColor,
          // added
          color: ColorRes.blackColor,
          type: MaterialType.card,
          elevation: 5,
          borderRadius: BorderRadius.circular(50.0),
          child: child),
    );
  }

  static detailDialog(BuildContext context, String title, String text) {
    showDialog(
        context: context,
        builder: (_) => Center(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: Utils.getSize(17)),
              width: Get.width,
              height: Utils.getSize(260),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Utils.getSize(20), vertical: Utils.getSize(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: Utils.getSize(22),
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          )),
                      SizedBox(height: Utils.getSize(10)),
                      Text(text,
                          style: TextStyle(
                            fontSize: Utils.getSize(15),
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          )),
                      SizedBox(height: Utils.getSize(30)),
                      // SizedBox(
                      //     width: Get.width,
                      //     child: raisedButton("Got it !", () {})),
                    ],
                  ),
                ),
              ),
            )));
  }

  static getCacheNetworkImage({required String imageUrl, required Widget? placeholderWidget, double? height, BoxFit? fit, double? width}) {
    if ((imageUrl.length) > 0) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(
          value: downloadProgress.progress,
          color: ColorRes.whiteColor,
        )),
        errorWidget: (context, url, error) {
          print("=====error in  image====${error.toString()}");
          return placeholderWidget!;
        },
      );
    } else {
      return placeholderWidget!;
    }
  }

  static showConfirmDialog({
    Function? positiveTap,
    Function? negativeTap,
    String? positiveButtonText,
    String? negativeButtonText,
    String? title,
    String? description,
    bool? showTitleInCenter,
    Widget? icon,
  }) {
    Get.dialog(
      Center(
        child: SizedBox(
          width: Get.width * 0.9,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorRes.whiteColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(18.getSize),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: (showTitleInCenter ?? false) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: [
                  Center(child: icon ?? const SizedBox.shrink()),
                  Column(
                    crossAxisAlignment: (showTitleInCenter ?? false) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        text: title ?? "Are you Sure ?",
                        color: ColorRes.blackColor,
                        textAlign: TextAlign.center,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      10.heightSpacer,
                      BaseText(
                        text: description ?? '',
                        color: ColorRes.blackColor,
                        textAlign: TextAlign.start,
                        fontSize: 17,
                      ),
                    ],
                  ),
                  25.heightSpacer,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: BaseRaisedButton(
                          onPressed: () {
                            if (negativeTap != null) {
                              negativeTap();
                            }
                            Get.back();
                          },
                          buttonText: negativeButtonText ?? "Cancel",
                          textColor: ColorRes.blackColor,
                          buttonColor: ColorRes.whiteColor,
                        ),
                      ),
                      10.widthSpacer,
                      Expanded(
                        child: BaseRaisedButton(
                          textColor: ColorRes.whiteColor,
                          onPressed: () async {
                            if (positiveTap != null) {
                              positiveTap();
                            }
                            Get.back();
                          },
                          buttonText: positiveButtonText ?? "Yes",
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static playBeepSound() async {
    final player = AudioPlayer();
    await player.play(AssetSource("sound/beep.mp3"));
  }

  static playRefreshSound() async {
    final player = AudioPlayer();
    await player.play(AssetSource("sound/refresh.mp3"));
  }

  static performLogout({bool isFromAppInterceptors = false}) async {
    String? deviceId = Injector.prefs?.getString(PrefKeys.deviceId);
    // if (isFromAppInterceptors) {
    print("=======>$deviceId");
    if(deviceId != null && deviceId != '') {
      CommonResponse? commonResponse = await DataSource.instance.logout(body: {"deviceId": deviceId},);
      if(commonResponse != null) {
        if(commonResponse.message != null) {
          Utils.showSuccessToast(commonResponse.message);
        }
      } else {
        Utils.showSuccessToast("Something went wrong!!");
      }
    }
    // }
    Injector.prefs?.remove(PrefKeys.email);
    Injector.prefs?.remove(PrefKeys.accessToken);
    Injector.prefs?.remove(PrefKeys.userData);
    Injector.prefs?.remove(PrefKeys.isUserVerified);
    // Get.offAll(LoginView(isFromIntro: false, isFromCreate: false, isFromKYC: false,));
    Utils.transitionWithOffAll(const Intro3View());
  }

  static formatDate(DateTime selectedDate, {String? format}) {
    String formattedDate = DateFormat(format ?? 'yyyy-MM-dd').format(selectedDate);
    return formattedDate;
  }

  static getImageSelectionBottomSheet(Function successCallBack) {
    Get.bottomSheet(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: ColorRes.transparentColor,
          margin: EdgeInsets.symmetric(horizontal: Utils.getSize(28), vertical: Utils.getSize(25)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x28000000),
                      blurRadius: 18,
                      offset: Offset(0, 4),
                    ),
                  ],
                  color: ColorRes.whiteColor,
                ),
                child: Column(
                  children: [
                    InkResponse(
                      onTap: () {
                        selectImageFromGallery(successCallBack);
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: Utils.getSize(20), bottom: Utils.getSize(15)),
                        child: Center(
                          child: BaseText(
                            text: "Gallery",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: ColorRes.blackColor,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: ColorRes.textGreyColor,
                    ),
                    InkResponse(
                      onTap: () {
                        selectImageFromCamera(successCallBack);
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: Utils.getSize(15), bottom: Utils.getSize(20)),
                        child: Center(
                          child: BaseText(
                            text: "Camera",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: ColorRes.blackColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Utils.getSize(20)),
              InkResponse(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x28000000),
                        blurRadius: 18,
                        offset: Offset(0, 4),
                      ),
                    ],
                    color: ColorRes.whiteColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: Utils.getSize(20)),
                      BaseText(
                        text: "Cancel",
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: ColorRes.redColor,
                      ),
                      SizedBox(height: Utils.getSize(20)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static getImageSelectionBottomSheetCustom(Function successCallBack) {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            color: ColorRes.transparentColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.getSize, vertical: 20.getSize),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.getSize),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x28000000),
                        blurRadius: 18,
                        offset: Offset(0, 4),
                      ),
                    ],
                    color: ColorRes.whiteColor,
                  ),
                  child: Column(
                    children: [
                      InkResponse(
                        splashColor: ColorRes.transparentColor,
                        onTap: () {
                          selectImageFromGallery(successCallBack);
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.getSize),
                          child: Center(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 24.getSize,
                                  color: ColorRes.blackColor,
                                ),
                                10.widthSpacer,
                                BasePangramText(
                                  text: "Select photo from gallery",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: ColorRes.blackColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      12.heightSpacer,
                      Divider(
                        color: ColorRes.textGreyColor,
                        height: 0,
                      ),
                      12.heightSpacer,
                      InkResponse(
                        splashColor: ColorRes.transparentColor,
                        onTap: () {
                          selectImageFromCamera(successCallBack);
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.getSize),
                          child: Center(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.camera_alt_rounded,
                                  size: 24.getSize,
                                  color: ColorRes.blackColor,
                                ),
                                10.widthSpacer,
                                BasePangramText(
                                  text: "Click photo from camera",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: ColorRes.blackColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static selectImageFromGallery(Function? successCallBack) async {
    XFile? temp;
    temp = await _picker.pickImage(source: ImageSource.gallery);
    if (temp != null && temp.path.isNotEmpty) {
      // if (await temp.length() > 4e+6) {
      temp = await compressImageSize(temp);
      // }
      if (successCallBack != null) {
        successCallBack(temp);
      }
    }
  }

  static selectImageFromCamera(Function? successCallBack, {bool? isOpenFrontCam}) async {
    XFile? temp;
    temp = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: isOpenFrontCam ?? false ? CameraDevice.front : CameraDevice.rear,
    );
    if (temp != null && temp.path.isNotEmpty) {
      // if (await temp.length() > 4e+6) {
      temp = await compressImageSize(temp);
      // }
      if (successCallBack != null) {
        successCallBack(temp);
      }
    }
  }

  static compressImageSize(XFile image) async {
    final lastIndex = image.path.split('/');
    lastIndex.removeLast();
    final outPath = "${lastIndex.join('/')}/compressed.jpeg";
    var result = await FlutterImageCompress.compressAndGetFile(
      image.path,
      outPath,
      quality: 80,
      format: CompressFormat.jpeg,
    );
    if ((await result?.length() ?? 0) > 4e+6) {
      Utils.showErrToast("The image dimensions are too large. Kindly use another image");
      return;
    }
    return result;
  }

  static transitionWithTo(dynamic page, {dynamic argument}) {
    if (kDebugMode) {
      print("IN TO FUNCTION UTILS");
    }
    Get.to(page,
        transition: Transition.fadeIn, // choose your page transition accordingly
        duration: const Duration(milliseconds: 300),
        arguments: argument);
  }

  static transitionWithOffAll(dynamic page, {dynamic argument}) {
    if (kDebugMode) {
      print("IN OFF ALL FUNCTION UTILS");
    }
    Get.offAll(
      page, transition: Transition.fadeIn, // choose your page transition accordingly
      duration: const Duration(milliseconds: 300),
      arguments: argument,
    );
  }

  static transitionWithOff(dynamic page, {dynamic argument}) {
    if (kDebugMode) {
      print("IN OFF ALL FUNCTION UTILS");
    }
    Get.off(
      page, transition: Transition.fadeIn, // choose your page transition accordingly
      duration: const Duration(milliseconds: 300),
      arguments: argument,
    );
  }

  static transitionWithOffUntil(dynamic page, {dynamic argument}) {
    if (kDebugMode) {
      print("IN OFF ALL FUNCTION UTILS");
    }
    Get.offUntil(
      page,
      (route) => true,
    );
  }

  static transitionWithClose(dynamic page, {dynamic argument}) {
    if (kDebugMode) {
      print("IN OFF ALL FUNCTION UTILS");
    }
    Get.close(page);
  }
}
