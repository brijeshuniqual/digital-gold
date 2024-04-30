import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:untitled/constants/constant.dart';
import 'package:untitled/screens/kyc_verification_module/kyc_verification_view.dart';

import '../../constants/app.export.dart';
import '../home_module/home_view.dart';

class EmailVerificationController extends GetxController {

  bool isFromLogin;
  EmailVerificationController({required this.isFromLogin});

  List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  List<TextEditingController> otpControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  late Timer timer;
  String email = '';
  String newEmail = '';
  int secondsRemaining = 30;
  bool isResendEnable = false;
  late TapGestureRecognizer editTapGestureRecognizer;
  late TapGestureRecognizer resendTapGestureRecognizer;
  TextEditingController newEmailC = TextEditingController();
  FocusNode keyboardFocus = FocusNode();

  @override
  void onInit() {

    loadEmail();
    editTapGestureRecognizer = TapGestureRecognizer()..onTap = editEmail;
    resendTapGestureRecognizer = TapGestureRecognizer()..onTap = resendOTP;
    newEmailC.text = email;

    startTimer();

    addListeners();

    super.onInit();
  }

  void addListeners() {
    for (int i = 0; i < 6; i++) {
      // focusNodes[i].addListener(() {
      //   // if (otpControllers[i].text.length == 1) {
      //   //   if(i!=5) {
      //   //     focusNodes[i + 1].requestFocus();
      //   //   }
      //   // }
      //   // if(otpControllers[i].text.isEmpty) {
      //   //   if(i!=0) {
      //   //     focusNodes[i-1].requestFocus();
      //   //   }
      //   // }
      //   if(i!=5) {
      //     if (focusNodes[i].hasFocus && otpControllers[i].text.length == 1) {
      //       focusNodes[i + 1].requestFocus();
      //     }
      //   }
      //
      // });

      otpControllers[i].addListener(() {
        if (otpControllers[i].text.length == 1) {
          if(i!=5) {
            focusNodes[i + 1].requestFocus();
          }
        }
        // if(otpControllers[i].text.isEmpty) {
        //   if(i!=0) {
        //     focusNodes[i-1].requestFocus();
        //   }
        // }
      });
    }
  }

  void removeListeners() {
    for (int i = 0; i < 5; i++) {
      otpControllers[i].removeListener(() {});
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (timer) {
      if (secondsRemaining == 0) {
        isResendEnable = true;
        timer.cancel();
      } else {
        secondsRemaining--;
      }
      update();
    });
  }

  String getFormattedTime() {
    int minutes = secondsRemaining ~/ 60;
    int seconds = secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  validateOPTField() {
    for (var c in otpControllers) {
      if (c.text.trim().isEmpty) {
        Utils.showErrToast('Please enter OTP');
        return false;
      }
    }
    // return true;
    sendOTPVerifyRequest();
  }

  sendOTPVerifyRequest() async {
    String otp = '';
    for (var c in otpControllers) {
      otp += c.text.trim();
    }

    Map<String, dynamic> body = {
      "email": email,
      "otp": otp,
    };

    try {
      Utils.showCircularProgressLottie(true);
      print('before=================');
      CommonResponse? commonResponse = await DataSource.instance.verifyOTP(
        body: body,
      );
      print('=================after');
      Utils.showCircularProgressLottie(false);

      if (commonResponse != null) {
        if (commonResponse.status == 201) {

          clearOTPFields();
          newEmailC.clear();
          timer.cancel();

          await Injector.setIsUserVerified(true);

          Get.dialog(
            routeSettings: const RouteSettings(),
            barrierDismissible: false,
            AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorRes.whiteColor,
                    borderRadius: BorderRadius.circular(20.getSize),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 28.getSize, vertical: 34.getSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        Utils.getAssetsImg('verified'),
                        width: 100.getSize,
                        height: 100.getSize,
                      ),
                      24.heightSpacer,
                      BasePangramText(
                        text: 'Email verified successfully',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: ColorRes.blackColor,
                      ),
                      8.heightSpacer,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.getSize),
                        child: BasePangramText(
                          text: 'Yahoo! You have successfully verified the account',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ColorRes.greyColor,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ).then((value) {
            // This block executes when the dialog is dismissed
            if (value == null) {
              // Handle dismissal via back button
              print("Dialog dismissed via back button");
            } else {
              // Handle dismissal via other means (e.g., button press)
              print("Dialog dismissed via other means");
            }
          });


          Future.delayed(const Duration(seconds: 2), () {
            if(isFromLogin) {
              Utils.transitionWithClose(1);
              Utils.transitionWithOffAll(const HomeView());

              // temporary
              // Utils.transitionWithClose(2);
              // Utils.transitionWithTo(const KYCVerificationView());
            } else {
              Utils.transitionWithClose(2);
              Utils.transitionWithTo(const KYCVerificationView());
            }
          });
          // return true;
        }
      } else {
        // return false;
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  changeLanguage() {
    if (Injector.getSelectedLanguage() == 'en') {
      Injector.setSelectedLanguage('hi');
      Utils.showSuccessToast('Language change to Hindi');
    } else if (Injector.getSelectedLanguage() == 'hi') {
      Injector.setSelectedLanguage('en');
      Utils.showSuccessToast('Language change to English');
    }
  }

  goToBackScreen() {
    Utils.transitionWithClose(1);
  }

  loadEmail() {
    email = Injector.getEmail() ?? '';
  }

  editEmail() {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            decoration: BoxDecoration(
              color: ColorRes.whiteColor,
              borderRadius: BorderRadius.circular(20.getSize),
            ),
            padding: EdgeInsets.symmetric(horizontal: 17.getSize, vertical: 22.getSize),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BasePangramText(
                  text: 'Change email address',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: ColorRes.blackColor,
                ),
                26.heightSpacer,
                Row(
                  children: [
                    BasePangramText(
                      text: 'Email address',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ColorRes.blackColor,
                    ),
                  ],
                ),
                8.heightSpacer,
                BasePangramTextField(
                  controller: newEmailC,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                ),
                20.heightSpacer,
                Row(
                  children: [
                    Expanded(
                      child: BaseRaisedButton(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        buttonColor: ColorRes.btnGreyColor.withOpacity(0.11),
                        textColor: ColorRes.blackColor,
                        borderRadius: 20.getSize,
                        buttonText: 'Cancel',
                        onPressed: () {
                          Utils.transitionWithClose(1);
                        },
                      ),
                    ),
                    15.widthSpacer,
                    Expanded(
                      child: BaseRaisedButton(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        buttonColor: ColorRes.yellowColor,
                        textColor: ColorRes.blackColor,
                        borderRadius: 20.getSize,
                        buttonText: 'Update',
                        onPressed: () {
                          validateNewEmail();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  validateNewEmail() {
    if (newEmailC.text.trim() == email) {
      Utils.showErrToast('Please change email');
      return false;
    } else if (newEmailC.text.trim().isEmpty) {
      Utils.showErrToast('Please enter new email');
      return false;
    } else if (!(Utils.validateEmail(newEmailC.text.trim()) ?? false)) {
      Utils.showErrToast('Please enter valid email address');
      return false;
    }

    sendUpdateEmailAPI();
  }

  sendUpdateEmailAPI() async {
    newEmail = newEmailC.text.trim();
    Map<String, dynamic> body = {
      "oldEmail": email,
      "email": newEmail,
    };

    try {
      Utils.showCircularProgressLottie(true);
      print('before=================');
      CommonResponse? commonResponse = await DataSource.instance.changeEmail(body: body);
      print('=================after');
      Utils.showCircularProgressLottie(false);

      if (commonResponse != null && commonResponse.status == 201) {
        Injector.setEmail(newEmail);
        email = newEmail;
        Utils.showSuccessToast(commonResponse.message);
        Utils.transitionWithClose(1);

        resendOTP();
      } else {
        if (commonResponse != null && commonResponse.message != null) {
          Utils.showErrToast(commonResponse.message);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  resendOTP() async {
    Map<String, dynamic> body = {
      "email": email,
    };

    try {
      Utils.showCircularProgressLottie(true);
      print('before=================');
      CommonResponse? commonResponse = await DataSource.instance.resendOTP(body: body);
      print('=================after');
      Utils.showCircularProgressLottie(false);

      if (commonResponse != null && commonResponse.status == 201) {
        Utils.showSuccessToast(commonResponse.message);
        clearOTPFields();
        timer.cancel();
        secondsRemaining = 30;
        isResendEnable = false;
        startTimer();
      } else {
        if (commonResponse != null && commonResponse.message != null) {
          Utils.showErrToast(commonResponse.message);
        }
      }
    } catch (e) {
      print(e.toString());
    }

    update();
  }

  @override
  void onClose() {
    editTapGestureRecognizer.dispose();
    resendTapGestureRecognizer.dispose();
    newEmailC.clear();

    timer.cancel();
    removeListeners();
    super.onClose();
  }

  clearOTPFields() {
    for(var c in otpControllers) {
      c.clear();
    }
  }

  // handleKeyPress(RawKeyEvent event) {
  //
  //   if (event.logicalKey == LogicalKeyboardKey.delete && event.isKeyPressed(LogicalKeyboardKey.delete)) {
  //     // focusIndex--;
  //     for(int i=1;i<6;i++) {
  //       if(focusNodes[i].hasFocus) {
  //         focusNodes[i-1].requestFocus();
  //       }
  //     }
  //   } else if(event.logicalKey != LogicalKeyboardKey.delete && !event.isKeyPressed(LogicalKeyboardKey.delete)) {
  //     // focusIndex++;
  //     for(int i=0;i<5;i++) {
  //       if(focusNodes[i].hasFocus) {
  //         focusNodes[i+1].requestFocus();
  //       }
  //     }
  //   }
  // }

  bool keyPressed = false;

  void handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent && !keyPressed) {
      keyPressed = true;

      if (event.logicalKey == LogicalKeyboardKey.backspace && event.isKeyPressed(LogicalKeyboardKey.backspace)) {
        // handle delete key press
        for (int i = 1; i < 6; i++) {
          if (focusNodes[i].hasFocus) {
            focusNodes[i - 1].requestFocus();

            break;
          }
        }
      } else if(event.logicalKey != LogicalKeyboardKey.backspace && !event.isKeyPressed(LogicalKeyboardKey.backspace)) {
        for(int i=0;i<6;i++) {
          if(focusNodes[i].hasFocus && otpControllers[i].text.length == 1 && i != 5) {
            focusNodes[i+1].requestFocus();
            break;
          }
        }
      }
    } else if (event is RawKeyUpEvent) {
      keyPressed = false;
    }
  }
}
