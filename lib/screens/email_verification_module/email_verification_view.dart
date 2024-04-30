import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/constants/constant.dart';
import 'package:untitled/screens/email_verification_module/email_verification_controller.dart';

import '../../constants/app.export.dart';
import '../kyc_verification_module/kyc_verification_view.dart';

class EmailVerificationView extends StatelessWidget {
  bool isFromLogin;
  EmailVerificationView({super.key, required this.isFromLogin});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailVerificationController>(
        init: EmailVerificationController(isFromLogin: isFromLogin),
        dispose: (_) => Get.delete<EmailVerificationController>(),
        builder: (_) {
          _.isFromLogin = isFromLogin;
          return Scaffold(
            bottomNavigationBar: verifyBtnWithHeight(_),
            body: mainBody(_, context),
          );
        });
  }

  mainBody(EmailVerificationController _, BuildContext context) {
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
                        _.goToBackScreen();
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
                  text: 'Email Verification',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: ColorRes.whiteColor,
                ),
                8.heightSpacer,
                RichText(
                  text: TextSpan(
                    text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: ColorRes.greyColor,
                    ),
                    children: [
                      TextSpan(
                        recognizer: _.editTapGestureRecognizer,
                        text: ' EDIT',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: ColorRes.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
                31.heightSpacer,
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.getSize),
            child: Column(
              children: [
                34.heightSpacer,
                Row(
                  children: [
                    BasePangramText(
                      text: 'Enter verification code',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: ColorRes.blackColor,
                    ),
                  ],
                ),
                14.heightSpacer,
                RawKeyboardListener(
                  focusNode: _.keyboardFocus,
                  onKey: (event) {
                    _.handleKeyPress(event);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      _.otpControllers.length,
                      (index) {
                        return SizedBox(
                          width: 50.getSize,
                          height: 50.getSize,
                          child: BasePangramTextField(
                            autofocus: index == 0 ? true : false,
                            focusNode: _.focusNodes[index],
                            maxLength: 1,
                            controller: _.otpControllers[index],
                            hintText: '0',
                            hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: ColorRes.silverColor),
                            contentPadding: EdgeInsets.zero,
                            textAlign: TextAlign.center,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.getSize),
                              borderSide: BorderSide(
                                color: ColorRes.blackColor,
                                width: Utils.getSize(1.5),
                              ),
                            ),
                            textInputType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            textInputAction: index == _.otpControllers.length - 1 ? TextInputAction.done : TextInputAction.next,
                            onTap: () {
                              print("object");
                            },
                            onFieldSubmitted: (v) {
                              print('submit');
                              if (index == 5) {
                                Utils.hideKeyboard();
                              }
                            },
                            onEditingComplete: () {
                              print("com");
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                14.heightSpacer,
                RichText(
                  text: TextSpan(
                    text: "OTP sent on email. Haven't received?",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: ColorRes.blackColor),
                    children: [
                      const TextSpan(text: ' '),
                      TextSpan(
                        recognizer: _.isResendEnable ? _.resendTapGestureRecognizer : null,
                        text: 'Resend',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: _.isResendEnable ? ColorRes.yellowColor : ColorRes.yellowColor.withOpacity(0.3),
                        ),
                      )
                    ],
                  ),
                ),
                8.heightSpacer,
                BasePangramText(
                  text: _.getFormattedTime(),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: ColorRes.blackColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  verifyBtnWithHeight(EmailVerificationController _) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        verifyBtn(_),
        16.heightSpacer,
      ],
    );
  }

  verifyBtn(EmailVerificationController _) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.getSize),
      child: Row(
        children: [
          Expanded(
            child: BaseRaisedButton(
              buttonColor: ColorRes.yellowColor,
              borderRadius: 20.getSize,
              textColor: ColorRes.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              buttonText: 'Verify',
              onPressed: () {
                _.validateOPTField();
              },
            ),
          ),
        ],
      ),
    );
  }
}
