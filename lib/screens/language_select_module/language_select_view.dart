import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/base_class/base_text.dart';
import 'package:untitled/constants/constant.dart';
import 'package:untitled/screens/language_select_module/language_select_controller.dart';

import '../../constants/app.export.dart';

class LanguageSelectView extends StatelessWidget {
  const LanguageSelectView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageSelectController>(
        init: LanguageSelectController(),
        dispose: (_) => Get.delete<LanguageSelectController>(),
        builder: (_) {
          return Scaffold(
            body: mainBody(_),
          );
        });
  }

  mainBody(LanguageSelectController _) {
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

  allDataPart(LanguageSelectController _) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.getSize, vertical: 30.getSize),
      child: Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          languageBoxs(_),
          const Spacer(
            flex: 1,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BasePangramText(
                      text: 'Choose app language',
                      fontWeight: FontWeight.w800,
                      fontSize: 26,
                      color: ColorRes.whiteColor,
                    ),
                    12.heightSpacer,
                    BasePangramText(
                      text: 'We support multiple languages to enhance your experience. Please select your preferred language from the options above',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: ColorRes.greyColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          22.heightSpacer,
          Row(
            children: [
              Expanded(
                child: BaseRaisedButton(
                  buttonColor: ColorRes.yellowColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  buttonText: 'Select',
                  textColor: ColorRes.blackColor,
                  borderRadius: 20.getSize,
                  onPressed: () {
                    _.goToNextScreen();
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  languageBoxs(LanguageSelectController _) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              _.toggleEnglishSelection(false);
            },
            child: boxContainer(firstText: 'Hindi', secondText: 'हिंदी', isSelected: !_.isEnglishSelected,),
          ),
        ),
        20.widthSpacer,
        Expanded(
          child: InkWell(
            onTap: () {
              _.toggleEnglishSelection(true);
            },
            child: boxContainer( firstText: 'English', secondText: 'अंग्रेज़ी', isSelected: _.isEnglishSelected),
          ),
        ),
      ],
    );
  }

  boxContainer({required String firstText, required String secondText,required bool isSelected}) {
    return Container(
      padding: EdgeInsets.all(Utils.getSize(17.5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.getSize),
        border: Border.all(
          color: isSelected ? ColorRes.yellowColor : ColorRes.yellowColor.withOpacity(0.5),
          width: Utils.getSize(1.5),
        ),
      ),
      child: Column(
        children: [
          BasePoppinsText(
            text: firstText,
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: ColorRes.yellowColor,
          ),
          7.heightSpacer,
          BasePoppinsText(
            text: secondText,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: ColorRes.yellowColor,
          ),
        ],
      ),
    );
  }
}
