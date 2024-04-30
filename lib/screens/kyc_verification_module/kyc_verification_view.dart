import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:untitled/constants/constant.dart';
import 'package:untitled/screens/kyc_verification_module/kyc_under_review_module/kyc_under_view.dart';
import 'package:untitled/screens/kyc_verification_module/kyc_verification_controller.dart';
import 'package:untitled/screens/login_module/login_view.dart';

import '../../constants/app.export.dart';

class KYCVerificationView extends StatelessWidget {
  const KYCVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KYCVerificationController>(
        init: KYCVerificationController(),
        dispose: (_) => Get.delete<KYCVerificationController>(),
        builder: (_) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (didPop) {
                return;
              }
              Utils.transitionWithOffAll(LoginView(
                isFromIntro: false,
                isFromCreate: true,
                isFromKYC: true,
              ));
            },
            child: Scaffold(
              body: mainBody(_),
            ),
          );
        });
  }

  mainBody(KYCVerificationController _) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.getSize, vertical: 18.getSize),
          decoration: BoxDecoration(
            color: ColorRes.blackColor,
            image: DecorationImage(
                image: AssetImage(
                  Utils.getAssetsImg('design'),
                ),
                fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        // _.goToBackScreen();
                        Utils.transitionWithOffAll(LoginView(
                          isFromIntro: false,
                          isFromCreate: true,
                          isFromKYC: true,
                        ));
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 24.getSize,
                        color: ColorRes.whiteColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _.changeLanguage();
                      },
                      child: Image.asset(
                        Utils.getAssetsImg('change_lan'),
                        width: 24.getSize,
                        height: 24.getSize,
                      ),
                    ),
                  ],
                ),
                26.heightSpacer,
                BasePangramText(
                  text: 'KYC verification',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: ColorRes.whiteColor,
                ),
                8.heightSpacer,
                BasePangramText(
                  text: 'We need this to confirm your reside and verify who you are. Data processed securely',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ColorRes.greyColor,
                ),
                31.heightSpacer,
              ],
            ),
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.getSize, vertical: 20.getSize),
            child: Column(
              children: [
                cardDetail(_, text: 'Aadhaar card details', hintText: 'Enter Aadhaar card number', controller: _.aadhaarNoC, isAadhaar: true),
                12.heightSpacer,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: uploadImgCard(
                      _,
                      text: 'Front side  photo',
                      onTap: () {
                        _.uploadImg('Front Aadhar');
                      },
                      img: _.frontAadhaarImg,
                      whichImg: 'Front Aadhar',
                    ),),
                    7.widthSpacer,
                    Expanded(child: uploadImgCard(
                      _,
                      text: 'Back side photo',
                      onTap: () {
                        _.uploadImg('Back Aadhar');
                      },
                      img: _.backAadhaarImg,
                      whichImg: 'Back Aadhar',
                    ),),
                  ],
                ),
                25.heightSpacer,
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    14.widthSpacer,
                    BasePangramText(
                      text: 'OR',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorRes.blackColor,
                    ),
                    14.widthSpacer,
                    const Expanded(child: Divider()),
                  ],
                ),
                25.heightSpacer,
                cardDetail(_, text: 'PAN card details', hintText: 'Enter PAN card number', controller: _.panNoC, isAadhaar: false),
                12.heightSpacer,
                Row(
                  children: [
                    Expanded(child: uploadImgCard(
                      _,
                      text: 'Pan card photo',
                      onTap: () {
                        _.uploadImg('Pan');
                      },
                      img: _.panImg,
                      whichImg: 'Pan',
                    ),),
                    7.widthSpacer,
                    const Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
                34.heightSpacer,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.getSize),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'By using this service, you agree to App name ',
                      style: TextStyle(fontFamily: 'Pangram', fontSize: 12, fontWeight: FontWeight.w400, color: ColorRes.termsColor),
                      children: [
                        TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(color: ColorRes.blackColor),
                        ),
                        const TextSpan(
                          text: ' and ',
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(color: ColorRes.blackColor),
                        ),
                      ],
                    ),
                  ),
                ),
                16.heightSpacer,
                Row(
                  children: [
                    Expanded(
                      child: BaseRaisedButton(
                        borderRadius: 20.getSize,
                        buttonColor: ColorRes.yellowColor,
                        buttonText: 'Continue',
                        textColor: ColorRes.blackColor,
                        onPressed: () {
                          _.validateFields();
                          // Utils.transitionWithTo(const KYCUnderView());
                        },
                      ),
                    ),
                  ],
                ),
                10.heightSpacer,
              ],
            ),
          ),
        ))
      ],
    );
  }

  uploadImgCard(KYCVerificationController _, {required String text, required Function() onTap, required XFile? img, required String whichImg}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(8.getSize),
                decoration: BoxDecoration(
                  color: ColorRes.whiteColor,
                  borderRadius: BorderRadius.circular(12.getSize),
                  border: Border.all(color: ColorRes.blackColor.withOpacity(0.04), width: 1.getSize),
                  boxShadow: [
                    BoxShadow(
                      color: ColorRes.shadowColor.withOpacity(0.08),
                      offset: Offset(0, 2.getSize),
                      blurRadius: 20.getSize,
                      spreadRadius: Utils.getSize(-2),
                    ),
                  ],
                ),
                child: img == null
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 35.getSize, vertical: 13.getSize),
                        decoration: BoxDecoration(
                          color: ColorRes.blackColor.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(6.getSize),
                        ),
                        child: img == null
                            ? Image.asset(
                                Utils.getAssetsImg('card_pre'),
                                width: 74.getSize,
                                height: 48.getSize,
                              )
                            : null,
                      )
                    : ClipRRect(
                      borderRadius: BorderRadius.circular(6.getSize),
                      child: Image.file(
                        File(img.path),
                        fit: BoxFit.cover,
                        width: 144.getSize,
                        height: 74.getSize,
                      ),
                    ),
              ),
              if(img != null)
                Positioned(
                right: 0,
                top: 0,
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      _.delteImg(whichImg);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 6.getSize, right: 6.getSize),
                      child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle, color: ColorRes.redColor),
                        child: Icon(
                          Icons.close_rounded,
                          color: ColorRes.whiteColor,
                          size: 15.getSize,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          6.heightSpacer,
          BasePangramText(
            text: text,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorRes.blackColor,
          ),
        ],
      ),
    );
  }

  cardDetail(KYCVerificationController _,
      {required String text, required String hintText, required TextEditingController controller, required bool isAadhaar}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.getSize),
        color: ColorRes.whiteColor,
        border: Border.all(color: ColorRes.blackColor.withOpacity(0.04), width: Utils.getSize(1.2)),
        boxShadow: [
          BoxShadow(
            color: ColorRes.shadowColor.withOpacity(0.08),
            blurRadius: 20.getSize,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.getSize, vertical: 7.getSize),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.getSize, vertical: 10.getSize),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.getSize),
                    color: ColorRes.blackColor.withOpacity(0.06),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.getSize, vertical: 5.getSize),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.getSize),
                      color: ColorRes.blackColor,
                    ),
                    child: BasePangramText(
                      text: '1234',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ColorRes.whiteColor,
                    ),
                  ),
                ),
                7.widthSpacer,
                Expanded(
                  child: BasePangramText(
                    text: text,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorRes.blackColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 9.getSize, right: 5.getSize),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.getSize, vertical: 8.getSize),
                    decoration: BoxDecoration(
                      color: ColorRes.yellowColor,
                      borderRadius: BorderRadius.circular(8.getSize),
                    ),
                    child: BasePangramText(
                      text: 'Verify',
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: ColorRes.blackColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          9.heightSpacer,
          Padding(
            padding: EdgeInsets.only(left: 16.getSize, right: 8.getSize, bottom: 15.getSize),
            child: BasePangramTextField(
              maxLength: isAadhaar ? 12 : 10,
              controller: controller,
              textInputType: isAadhaar ? TextInputType.number : TextInputType.text,
              inputFormatters: isAadhaar
                  ? [
                      FilteringTextInputFormatter.digitsOnly,
                    ]
                  : [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                    ],
              textInputAction: TextInputAction.done,
              textCapitalization: isAadhaar ? null : TextCapitalization.characters,
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }
}
