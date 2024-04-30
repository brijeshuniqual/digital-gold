import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/constants/constant.dart';
import 'package:untitled/screens/create_account_module/create_account_controller.dart';

import '../../constants/app.export.dart';
import '../intro_module/intro_3_view.dart';
import '../login_module/login_view.dart';

class CreateAccountView extends StatelessWidget {
  bool isFromIntro;
  bool isFromLogin;
  bool? isFromKYC;
  CreateAccountView({super.key, required this.isFromIntro, required this.isFromLogin, required this.isFromKYC});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateAccountController>(
      init: CreateAccountController(isFromIntro: isFromIntro, isFromLogin: isFromLogin, isFromKYC: isFromKYC),
      dispose: (_) => Get.delete<CreateAccountController>(),
      builder: (_) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (didPop) {
              return;
            }

            Utils.transitionWithClose(1);

            // if(isFromIntro == true && isFromLogin == false) {
            //   Utils.transitionWithClose(1);
            // } else if(isFromIntro == false && isFromLogin == true) {
            //   Utils.transitionWithClose(1);
            // } else {
            //   print("no idea");
            // }
          },
          child: Scaffold(
            bottomNavigationBar: createBtnAndSignIn(_),
            body: mainBody(_),
          ),
        );
      },
    );
  }

  mainBody(CreateAccountController _) {
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
                  text: 'Create your account',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: ColorRes.whiteColor,
                ),
                8.heightSpacer,
                BasePangramText(
                  text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
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
              padding: EdgeInsets.symmetric(horizontal: 24.getSize),
              child: Column(
                children: [
                  24.heightSpacer,
                  uploadImgPart(_),
                  30.heightSpacer,
                  textFieldTitle(text: 'Full name'),
                  8.heightSpacer,
                  BasePangramTextField(
                    focusNode: _.nameFieldFocus,
                    controller: _.nameC,
                    hintText: 'Enter full name',
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z ]')),
                    ],
                    onFieldSubmitted: (text) {
                      _.emailFieldFocus.requestFocus();
                    },
                  ),
                  16.heightSpacer,
                  textFieldTitle(text: 'Email Address'),
                  8.heightSpacer,
                  BasePangramTextField(
                    focusNode: _.emailFieldFocus,
                    controller: _.emailC,
                    hintText: 'Enter email address',
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  createBtnAndSignIn(CreateAccountController _) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        16.heightSpacer,
        createAccountBtn(_),
        16.heightSpacer,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.getSize),
          child: RichText(
            text: TextSpan(
              recognizer: _.signInTapGestureRecognizer,
              text: 'Already have an account?',
              style: TextStyle(fontSize: 14.getSize, fontWeight: FontWeight.w500, color: ColorRes.blackColor, fontFamily: 'Pangram'),
              children: [
                TextSpan(
                  recognizer: _.signInTapGestureRecognizer,
                  text: ' ',
                  style: TextStyle(fontSize: 14.getSize, fontWeight: FontWeight.w400, color: ColorRes.blackColor, fontFamily: 'Pangram'),
                ),
                TextSpan(
                  recognizer: _.signInTapGestureRecognizer,
                  text: 'Sign in',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 14.getSize,
                    fontWeight: FontWeight.w700,
                    color: ColorRes.yellowColor,
                    fontFamily: 'Pangram',
                  ),
                ),
              ],
            ),
          ),
        ),
        16.heightSpacer,
      ],
    );
  }

  uploadImgPart(CreateAccountController _) {
    return InkWell(
      onTap: () {
        _.uploadImg();
      },
      child: Column(
        children: [
          Container(
            width: 80.getSize,
            height: 80.getSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.getSize),
              image: _.userImg == null
                  ? DecorationImage(
                      image: AssetImage(
                        Utils.getAssetsImg('upload_img'),
                      ),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: _.userImg == null
                ? Icon(
                    Icons.image_outlined,
                    size: 26.getSize,
                    color: ColorRes.yellowColor,
                  )
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.getSize),
                        child: Image.file(
                          File(_.userImg!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.getSize, right: 2.getSize),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              _.deleteImg();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorRes.redColor,
                                ),
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 13.getSize,
                                  color: ColorRes.whiteColor,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          8.heightSpacer,
          BasePangramText(
            text: 'Add profile photo',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: ColorRes.blackColor,
          ),
        ],
      ),
    );
  }

  createAccountBtn(CreateAccountController _) {
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
              buttonText: 'Create Account',
              onPressed: () {
                _.validateField();
              },
            ),
          ),
        ],
      ),
    );
  }

  textFieldTitle({required String text}) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            text: text,
            style: TextStyle(fontFamily: 'Pangram', fontSize: 12.getSize, fontWeight: FontWeight.w500, color: ColorRes.blackColor),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: ColorRes.redColor),
              )
            ],
          ),
        ),
      ],
    );
  }
}
