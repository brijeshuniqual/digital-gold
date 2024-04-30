import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/constants/constant.dart';
import 'package:untitled/screens/intro_module/intro_controller.dart';

import '../../constants/app.export.dart';

class Intro3View extends StatelessWidget {
  const Intro3View({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IntroController>(
      init: IntroController(),
      dispose: (_) => Get.delete<IntroController>(),
      builder: (_) {
        _.setIsFirstTime();
        return Scaffold(
          body: mainBody(_,context),
        );
      }
    );
  }

  mainBody(IntroController _, BuildContext context) {
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
      child: allDataPart(_,context),
    );
  }

  allDataPart(IntroController _, BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24.getSize, top: 20.getSize, right: 24.getSize),
            child: Row(
              children: [
                if(Navigator.of(context).canPop()) ...{
                  InkWell(
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        _.goToBackView();
                      } else {
                        SystemNavigator.pop();
                      }
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 24.getSize,
                      color: ColorRes.yellowColor,
                    ),
                  ),
                } else ... {
                  SizedBox(width: 24.getSize,),
                },
                const Spacer(),
                Image.asset(
                  Utils.getAssetsImg('title'),
                  width: 24.getSize,
                ),
                4.widthSpacer,
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ColorRes.gradient1Color,
                      ColorRes.gradient1Color,
                      ColorRes.gradient2Color,
                      ColorRes.gradient2Color,
                      ColorRes.gradient3Color,
                      ColorRes.gradient3Color,
                      ColorRes.gradient2Color,
                      ColorRes.gradient1Color,
                      ColorRes.gradient1Color,
                    ],
                  ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: BasePangramText(
                    text: 'Goldgrams',
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    _.changeLanguage();
                  },
                  child: Image.asset(
                    Utils.getAssetsImg('change_lan'),
                    width: 24.getSize,
                  ),
                ),
              ],
            ),
          ),
          37.heightSpacer,
          Expanded(
            child: imagePart(),
          ),
          34.heightSpacer,
          descriptionPart(),
          40.heightSpacer,
          createAccountBtn(_),
          16.heightSpacer,
          loginBtn(_),
          30.heightSpacer,
        ],
      ),
    );
  }

  loginBtn(IntroController _) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.getSize),
      child: Row(
        children: [
          Expanded(
            child: BaseRaisedButton(
              buttonColor: ColorRes.transparentColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              buttonText: 'Login',
              textColor: ColorRes.whiteColor,
              borderRadius: 20.getSize,
              borderColor: ColorRes.yellowColor,
              borderWidth: 2.getSize,
              onPressed: () {
                print('Login View');
                _.goToLoginView();
              },
            ),
          )
        ],
      ),
    );
  }

  createAccountBtn(IntroController _) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.getSize),
      child: Row(
        children: [
          Expanded(
            child: BaseRaisedButton(
              buttonColor: ColorRes.yellowColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              buttonText: 'Create Account',
              textColor: ColorRes.blackColor,
              borderRadius: 20.getSize,
              onPressed: () {
                _.goToCreateAccountView();
              },
            ),
          )
        ],
      ),
    );
  }

  descriptionPart() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.getSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasePangramText(
            text: 'Smart Investing, Smart Savings',
            fontWeight: FontWeight.w800,
            fontSize: 26,
            color: ColorRes.whiteColor,
          ),
          12.heightSpacer,
          BasePangramText(
            text: 'Id duis porta fringilla vitae. Facilisis dignissim volutpat tortor tincidunt nunc.',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: ColorRes.greyColor,
          ),
        ],
      ),
    );
  }

  imagePart() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 76.getSize),
      child: AspectRatio(
        aspectRatio: 224/306,
        child: Image.asset(
          Utils.getAssetsImg('intro7'),
          width: 224.getSize,
          height: 306.getSize,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
