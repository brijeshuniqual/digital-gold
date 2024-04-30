
import 'package:flutter/gestures.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:untitled/constants/app.export.dart';
import 'package:untitled/screens/create_account_module/create_account_model.dart';
import 'package:untitled/screens/email_verification_module/email_verification_view.dart';
import 'package:untitled/screens/intro_module/intro_3_view.dart';
import 'package:untitled/screens/login_module/login_view.dart';


class CreateAccountController extends GetxController {

  bool isFromIntro;
  bool isFromLogin;
  bool? isFromKYC;

  CreateAccountController({required this.isFromIntro,required this.isFromLogin,required this.isFromKYC});

  FocusNode nameFieldFocus = FocusNode();
  FocusNode emailFieldFocus = FocusNode();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  XFile? userImg;
  NewUserModel? newUser;
  late TapGestureRecognizer signInTapGestureRecognizer;


  @override
  onInit() {
    signInTapGestureRecognizer = TapGestureRecognizer()..onTap = signInTap;
    super.onInit();
  }


  goToEmailVerification() {
    Utils.transitionWithTo(EmailVerificationView(isFromLogin: false,));
  }

  uploadImg() {
    Utils.getImageSelectionBottomSheetCustom(successCallBack);
  }

  successCallBack(XFile? image) {
    if(image != null) {
      userImg = image;
      update();
    } else {
      Utils.showErrToast("Please try again");
    }
  }

  validateField() {
    if(nameC.text.trim().isEmpty) {
      Utils.showErrToast('Please enter name');
      return false;
    } else if(emailC.text.trim().isEmpty) {
      Utils.showErrToast('Please enter email address');
      return false;
    } else if(!(Utils.validateEmail(emailC.text.trim()) ?? false)) {
      Utils.showErrToast('Please enter valid email address');
      return false;
    }
    // return true;
    sendRegisterAPI();
  }

  sendRegisterAPI() async {
    var users = emailC.text.split('@');
    bool isMultiPart = false;

    if(userImg != null) {
      isMultiPart = true;
    }

    Map<String, dynamic> body = {
      "profilePic" : userImg == null ? '' : MultipartFile(userImg!.path, filename: "${users[0]}.png"),
      "email" : emailC.text.trim(),
      "name" : nameC.text.trim(),
    };

    print(body);

    try {
      Utils.showCircularProgressLottie(true);
      print('before=================');
      CommonResponse? commonResponse = await DataSource.instance.register(body: body, isMultiPart: isMultiPart,);
      print('=================after');
      Utils.showCircularProgressLottie(false);

      if (commonResponse != null && commonResponse.status == 201) {

        Injector.setEmail(emailC.text.trim());
        nameC.clear();
        emailC.clear();
        userImg = null;

        newUser = NewUserModel.fromJson(commonResponse.data);

        if (newUser != null) {
          Injector.setUserData(newUser!);
          if (newUser!.authentication!.accessToken != null) {
            Injector.setAccessToken(newUser!.authentication!.accessToken!);
            Utils.showSuccessToast(commonResponse.message);
            goToEmailVerification();
          } else {
            Utils.showErrToast('Something went wrong, Please try again.');
          }
        } else {
          Utils.showErrToast('Something went wrong, Please try again.');
        }

        // return true;
      } else {
        if (commonResponse != null && commonResponse.message != null) {
          Utils.showErrToast(commonResponse.message);
        } else {
          Utils.showErrToast('Something went wrong, Please try again.');
        }
      }
      update();
    } catch(e) {
      print(e.toString());
    }
    // return false;
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

  goToBackScreen() {

    Utils.transitionWithClose(1);

    // if(isFromIntro == true && isFromLogin == false) {
    //   Utils.transitionWithClose(1);
    // } else if(isFromIntro == false && isFromLogin == true) {
    //   Utils.transitionWithClose(1);
    // } else {
    //   print("no idea");
    // }
  }

  signInTap() {
    print('Sign In');

    emailC.clear();
    userImg = null;
    nameC.clear();

    if(isFromIntro) {
      Utils.transitionWithTo(LoginView(isFromIntro: false, isFromCreate: true, isFromKYC: null,));
    } else {
      Utils.transitionWithClose(1);
    }
  }

  @override
  void onClose() {
    nameFieldFocus.dispose();
    emailFieldFocus.dispose();
    nameC.clear();
    emailC.clear();
    userImg = null;
    signInTapGestureRecognizer.dispose();
    super.onClose();
  }

  deleteImg() {
    userImg = null;
    update();
  }
}