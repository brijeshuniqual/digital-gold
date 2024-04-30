
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/kyc_verification_module/kyc_under_review_module/kyc_under_view.dart';

import '../../common_model/common_response.dart';
import '../../constants/injector.dart';
import '../../constants/utils.dart';
import '../../network/data_source.dart';
import '../home_module/home_view.dart';

class KYCVerificationController extends GetxController {


  TextEditingController aadhaarNoC = TextEditingController();
  TextEditingController panNoC = TextEditingController();

  XFile? frontAadhaarImg;
  XFile? backAadhaarImg;
  XFile? panImg;

  String cardType = '';

  @override
  onInit() {

    super.onInit();
  }

  backAadhaarImgSuccessCallBack(XFile? image) {
    if(image != null) {
        backAadhaarImg = image;
      update();
    }
  }

  panImgSuccessCallBack(XFile? image) {
    if(image != null) {
        panImg = image;
      update();
    }
  }

  frontAadhaarImgSuccessCallBack(XFile? image) {
    if(image != null) {
        frontAadhaarImg = image;
      update();
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

  uploadImg(String whichImg) {
    Function callBack;
    if(whichImg == 'Front Aadhar') {
      callBack = frontAadhaarImgSuccessCallBack;
    } else if(whichImg == 'Back Aadhar') {
      callBack = backAadhaarImgSuccessCallBack;
    } else {
      callBack = panImgSuccessCallBack;
    }
    Utils.getImageSelectionBottomSheetCustom(callBack);
  }

  validateFields() {

    if(aadhaarNoC.text.trim().isEmpty && panNoC.text.trim().isEmpty) {
      Utils.showErrToast('Please enter Aadhaar or Pan detail');
      return;
    } else{
      if(aadhaarNoC.text.trim().isNotEmpty) {
        if(aadhaarNoC.text.length == 12) {
          if (frontAadhaarImg == null) {
            Utils.showErrToast('Please enter Aadhaar card\'s front images');
            return;
          } else if(backAadhaarImg == null) {
            Utils.showErrToast('Please enter Aadhaar card\'s back images');
            return;
          } else {
            cardType = 'aadhar';
          }
        } else {
          Utils.showErrToast('Please enter 12 digits Aadhaar card number');
          return;
        }
      } else {
        if(panImg == null) {
          Utils.showErrToast('Please enter Pan card\'s image');
          return;
        } else {
          cardType = 'pan';
        }
      }
    }

    Utils.transitionWithTo(KYCUnderView(isKYCUnderReview: true,));
    // sendKYCVerificationRequest();
  }

  sendKYCVerificationRequest() async {
    Map<String,dynamic> body;

    body = {
      "cardType": cardType,
      "cardNumber": cardType == 'aadhar' ? aadhaarNoC.text.trim() : panNoC.text.trim(),
      "frontSideImage": cardType == 'aadhar' ? MultipartFile(frontAadhaarImg!.path, filename: "frontAadhar.png") :MultipartFile(panImg!.path, filename: "panImg.png"),
      if(cardType == 'aadhar')
        "backSideImage": MultipartFile(backAadhaarImg!.path, filename: "backAadhar.png"),
    };


    try {
      Utils.showCircularProgressLottie(true);
      print('before=================');
      CommonResponse? commonResponse = await DataSource.instance.KYCVerification(body: body);
      print('=================after');
      Utils.showCircularProgressLottie(false);

      if (commonResponse != null && commonResponse.status == 201) {
        aadhaarNoC.clear();
        panNoC.clear();

        frontAadhaarImg = null;
        backAadhaarImg = null;
        panImg = null;
        if(commonResponse.message != null) {
          Utils.showSuccessToast(commonResponse.message);
          Utils.transitionWithTo(KYCUnderView(isKYCUnderReview: true,));
        }

        update();
      } else {
        if (commonResponse != null && commonResponse.message != null) {
          Utils.showErrToast(commonResponse.message);
        } else {
          Utils.showErrToast("Something went wrong!!");
        }
      }
    } catch(e) {
      print(e.toString());
    }

  }

  delteImg(String whichImg) {
    if(whichImg == 'Pan') {
      panImg = null;
    } else if(whichImg == 'Front Aadhar') {
      frontAadhaarImg = null;
    } else if(whichImg == 'Back Aadhar') {
      backAadhaarImg = null;
    }
    update();
  }

  @override
  void onClose() {
    aadhaarNoC.clear();
    panNoC.clear();

    frontAadhaarImg = null;
    backAadhaarImg = null;
    panImg = null;

    super.onClose();
  }

}