
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/constants/constant.dart';
import 'package:untitled/screens/home_module/home_controller.dart';

import '../../constants/app.export.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      dispose: (_) => Get.delete<HomeController>(),
      builder: (_) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (didPop) {
              return;
            }
            SystemNavigator.pop();
          },
          child: Scaffold(
            body: mainBody(_),
          ),
        );
      }
    );
  }

  mainBody(HomeController _) {

    if(_.user != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BasePangramText(text: _.user!.name ?? 'Demo'),
            BasePangramText(text: _.user!.email ?? 'Demo@gmail.com'),
            BasePangramText(text: _.selectedLanguage ?? 'No language selected'),
            BaseRaisedButton(buttonText: 'Logout', onPressed: () {
              showBackDialog();
            })
          ],
        ),
      );
    } else {
      return Image.asset(Utils.getAssetsImg('login_image'),);
    }
  }

  showBackDialog() {
    Get.dialog(AlertDialog(
      title: BasePangramText(text: 'LogOut',fontSize: 24,fontWeight: FontWeight.w600,color: ColorRes.blackColor,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BasePangramText(text: 'Are you sure you want to logout?'),
          16.heightSpacer,
          Row(
            children: [
              Expanded(
                child: BaseRaisedButton(buttonText: 'Cancel', onPressed: () {
                  Utils.transitionWithClose(1);
                }),
              ),
              10.widthSpacer,
              Expanded(
                child: BaseRaisedButton(buttonText: 'Logout', onPressed: () {
                  Utils.performLogout();
                }),
              ),

            ],
          ),
        ],
      ),
    ));
  }
}
