//
// import 'package:get/get.dart';
//
// import '../../helper/push_notification_helper.dart';
//
// class LoginController extends GetxController {
//   RxInt counter = 0.obs;
//
//   increment() => counter.value++;
//   PushNotificationHelper? pushNotificationHelper;
//
//   reset() {
//     counter.value = 0;
//     update();
//   }
//
//   void onInit(){
//     pushNotificationHelper = PushNotificationHelper();
//     pushNotificationHelper?.initPush();
//     super.onInit();
//   }
//
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/create_account_module/create_account_view.dart';

import '../../common_model/common_response.dart';
import '../../constants/app.export.dart';
import '../../constants/injector.dart';
import '../../constants/utils.dart';
import '../../network/data_source.dart';
import '../create_account_module/create_account_model.dart';
import '../email_verification_module/email_verification_view.dart';
import '../intro_module/intro_3_view.dart';

class LoginController extends GetxController {

  bool isFromIntro;
  bool isFromCreate;
  bool? isFromKYC;

  LoginController({required this.isFromIntro,required this.isFromCreate,required this.isFromKYC});

  late TapGestureRecognizer signUpTapGestureRecognizer;
  TextEditingController emailC = TextEditingController();
  NewUserModel? newUser;

  @override
  onInit() {
    signUpTapGestureRecognizer = TapGestureRecognizer()..onTap = signUp;

    super.onInit();
  }

  validateFields(){
    if(emailC.text.trim().isEmpty) {
      Utils.showErrToast('Please enter email address');
      return;
    } else if(!(Utils.validateEmail(emailC.text.trim()) ?? false)) {
      Utils.showErrToast('Please enter valid email address');
      return;
    }

    sendLoginRequest();
  }

  sendLoginRequest() async {
    Map<String, dynamic> body = {
      "email" : emailC.text.trim(),
    };

    // try {
      Utils.showCircularProgressLottie(true);
      print('before=================');
      CommonResponse? commonResponse = await DataSource.instance.login(body: body);
      print('=================after');
      Utils.showCircularProgressLottie(false);

      if (commonResponse != null && commonResponse.status == 201) {

        Injector.setEmail(emailC.text.trim());
        emailC.clear();

        if(commonResponse.data != null) {
          newUser = NewUserModel.fromJson(commonResponse.data);

          if (newUser != null) {
            Injector.setUserData(newUser!);
            if (newUser!.authentication!.accessToken != null) {
              Injector.setAccessToken(newUser!.authentication!.accessToken!);

              Utils.showSuccessToast(commonResponse.message);
              goToEmailVerification();
            } else {
              Utils.showErrToast('Something went wrong, Please login again.');
            }
          } else {
            Utils.showErrToast('Something went wrong, Please login again.');
          }
        } else {
          Utils.showErrToast('Something went wrong, Please login again.');
        }
      } else {
        if (commonResponse != null && commonResponse.message != null) {
          Utils.showErrToast(commonResponse.message);
        } else {
          Utils.showErrToast('Something went wrong, Please login again.');
        }
      }
      update();
    // } catch(e) {
    //   print(e.toString());
    // }
  }

  goToEmailVerification() {
    Utils.transitionWithTo(EmailVerificationView(isFromLogin: true,));
  }


  goToBackView(BuildContext context) {

    if(isFromKYC != null && isFromKYC == true) {
      Utils.transitionWithOffAll(const Intro3View());
    } else {
      if (Navigator.canPop(context)) {
        Utils.transitionWithClose(1);
      } else {
        SystemNavigator.pop();
      }
    }
    // if(isFromIntro == true && isFromCreate == false) {
    //   Utils.transitionWithClose(1);
    // } else if(isFromIntro == false && isFromCreate == true) {
    //   Utils.transitionWithClose(1);
    // } else {
    //   print("no idea");
    // }
  }

  changeLanguage() {
    if(Injector.getSelectedLanguage() == 'en') {
      Injector.setSelectedLanguage('hi');
      Utils.showSuccessToast('Language change to Hindi');
    } else if(Injector.getSelectedLanguage() == 'hi'){
      Injector.setSelectedLanguage('en');
      Utils.showSuccessToast('Language change to English');
    }
  }

  signUp() {

    emailC.clear();

    if(isFromKYC != null && isFromKYC == true) {
      Utils.transitionWithTo(CreateAccountView(isFromIntro: false, isFromLogin: true, isFromKYC: isFromKYC,));
    } else {
      if (isFromIntro == false && isFromCreate == false) {
        Utils.transitionWithTo(CreateAccountView(isFromIntro: false, isFromLogin: true, isFromKYC: false,));
      } else {
        if (isFromIntro) {
          Utils.transitionWithTo(CreateAccountView(isFromIntro: false, isFromLogin: true, isFromKYC: false,));
        } else {
          Utils.transitionWithClose(1);
        }
      }
    }

  }

  @override
  void onClose() {
    emailC.clear();
    signUpTapGestureRecognizer.dispose();

    super.onClose();
  }
}