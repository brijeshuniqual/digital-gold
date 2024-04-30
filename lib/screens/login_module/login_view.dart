// import '../../constants/app.export.dart';
// import 'login_contoller.dart';
//
// class LoginView extends StatelessWidget {
//   const LoginView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(context) {
//     return GetBuilder<LoginController>(
//       init: LoginController(),
//       dispose: (_) => Get.delete<LoginController>(),
//       builder: (_) {
//         return Scaffold(
//           body: mainBody(_),
//         );
//       },
//     );
//   }
//
//   mainBody(LoginController _) {
//     return SafeArea(
//       child: Column(
//         children: [
//           SizedBox(height: Utils.getSize(130)),
//           InkWell(
//             onTap: () {
//               Utils.showConfirmDialog(
//                 title: "Are you Sure?",
//                 description: "Do you want to logout ?",
//                 negativeTap: () {
//                   print("object tape negative");
//                 },
//                 positiveTap: () {
//                   print("object tape positive");
//                 },
//               );
//             },
//             child: getHeaderImageView(),
//           ),
//           BaseRaisedButton(
//             buttonText: "Done",
//             onPressed: () {
//             },
//           )
//         ],
//       ),
//     );
//   }
//
//   getHeaderImageView() {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: Utils.getSize(0)),
//         child: Image.asset(
//           Utils.getAssetsImg("login_image"),
//           height: Utils.getSize(170),
//           width: Utils.getSize(257),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:untitled/constants/constant.dart';
import 'package:untitled/screens/login_module/login_contoller.dart';

import '../../constants/app.export.dart';
import '../create_account_module/create_account_view.dart';
import '../intro_module/intro_3_view.dart';

class LoginView extends StatelessWidget {
  bool isFromIntro;
  bool isFromCreate;
  bool? isFromKYC;
  LoginView({super.key, required this.isFromIntro, required this.isFromCreate, required this.isFromKYC});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(isFromIntro: isFromIntro, isFromCreate: isFromCreate, isFromKYC: isFromKYC),
        dispose: (_) => Get.delete<LoginController>(),
        builder: (_) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (didPop) {
                return;
              }

              if (isFromKYC != null && isFromKYC == true) {
                // SystemNavigator.pop();
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
            },
            child: Scaffold(
              bottomNavigationBar: signInBtnAndSignUpText(_),
              body: mainBody(_, context),
            ),
          );
        });
  }

  mainBody(LoginController _, BuildContext context) {
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
                        _.goToBackView(context);
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
                  text: 'Welcome back!!',
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
            padding: EdgeInsets.symmetric(horizontal: 24.getSize),
            child: Column(
              children: [
                34.heightSpacer,
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Email Address',
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
                ),
                8.heightSpacer,
                BasePangramTextField(
                  controller: _.emailC,
                  hintText: 'Enter email address',
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  signInBtnAndSignUpText(LoginController _) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        signInBtn(_),
        16.heightSpacer,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.getSize),
          child: RichText(
            text: TextSpan(
              recognizer: _.signUpTapGestureRecognizer,
              text: 'Don’t have an account?',
              style: TextStyle(fontSize: 14.getSize, fontWeight: FontWeight.w500, color: ColorRes.blackColor, fontFamily: 'Pangram'),
              children: [
                TextSpan(
                  recognizer: _.signUpTapGestureRecognizer,
                  text: ' ',
                  style: TextStyle(fontSize: 14.getSize, fontWeight: FontWeight.w400, color: ColorRes.blackColor, fontFamily: 'Pangram'),
                ),
                TextSpan(
                  recognizer: _.signUpTapGestureRecognizer,
                  text: 'Sign up',
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

  signInBtn(LoginController _) {
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
              buttonText: 'Sign In',
              onPressed: () {
                _.validateFields();
              },
            ),
          ),
        ],
      ),
    );
  }
}
