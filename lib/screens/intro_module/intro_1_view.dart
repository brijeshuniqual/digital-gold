import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/constants/constant.dart';
import 'package:untitled/screens/intro_module/intro_3_view.dart';
import 'package:untitled/screens/intro_module/intro_controller.dart';

import '../../constants/app.export.dart';

class Intro1View extends StatelessWidget {
  const Intro1View({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IntroController>(
        init: IntroController(),
        dispose: (_) => Get.delete<IntroController>(),
        builder: (_) {
          return Scaffold(
            backgroundColor: ColorRes.blackColor,
            body: mainBody(_),
          );
        });
  }

  mainBody(IntroController _) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              Utils.getAssetsImg('main_back'),
            ),
            fit: BoxFit.cover),
      ),
      child: allDataPart(_),
    );
  }

  allDataPart(IntroController _) {
    return Column(
      children: [
        skipAndChangeLanguage(_),
        20.heightSpacer,
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 76.getSize,vertical: 78.getSize),
                child: AspectRatio(
                  aspectRatio: 224/306,
                  child: Image.asset(
                    Utils.getAssetsImg('intro1'),
                    width: 224.getSize,
                    height: 306.getSize,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 8 / 11,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    Utils.getAssetsImg('intro2'),
                    width: 120.getSize,
                    height: 170.getSize,
                    alignment: Alignment.bottomLeft,
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 8 / 11,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    Utils.getAssetsImg('intro3'),
                    width: 120.getSize,
                    height: 170.getSize,
                    alignment: Alignment.topRight,
                  ),
                ),
              ),
            ],
          ),
        ),
        15.heightSpacer,
        descriptionPart(),
        30.heightSpacer,
        nextBtn(_),
        30.heightSpacer,
      ],
    );
  }

  descriptionPart() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.getSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasePangramText(
            text: 'Own gold digitally, Anytime, anywhere',
            fontWeight: FontWeight.w800,
            fontSize: 26,
            color: ColorRes.whiteColor,
          ),
          12.heightSpacer,
          BasePangramText(
            text: 'Id duis porta fringilla vitae. Facilisis dignissim volutpat tortor tincidunt nunc.',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: ColorRes.greyColor,
          ),
        ],
      ),
    );
  }

  nextBtn(IntroController _) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.getSize),
      child: Row(
        children: [
          Expanded(
            child: BaseRaisedButton(
              buttonColor: ColorRes.yellowColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              buttonText: 'Next',
              textColor: ColorRes.blackColor,
              borderRadius: 20.getSize,
              onPressed: () {
                _.goToIntro2View();
              },
            ),
          )
        ],
      ),
    );
  }

  skipAndChangeLanguage(IntroController _) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 8.getSize, left: 24.getSize, right: 24.getSize),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
            10.widthSpacer,
            InkWell(
              onTap: () {
                // _.goToIntro3View();
                Utils.transitionWithOff(const Intro3View());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.getSize, vertical: 6.getSize),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30.getSize), border: Border.all(width: 1.getSize, color: ColorRes.whiteColor)),
                child: BasePangramText(
                  text: "Skip",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
