import 'package:flutter/cupertino.dart';
import 'package:untitled/constants/constant.dart';
import 'package:untitled/screens/splash_module/splash_controller.dart';

import '../../constants/app.export.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        dispose: (_) => Get.delete<SplashController>(),
        builder: (_) {
          return Scaffold(
            body: mainBody(),
          );
        });
  }

  mainBody() {
    // return Stack(
    //   clipBehavior: Clip.none,
    //   children: [
    //     Container(
    //       decoration: BoxDecoration(
    //         color: ColorRes.blackColor,
    //       ),
    //       child: Center(
    //           child: Image.asset(
    //         Utils.getAssetsImg('splash'),
    //         width: 116.getSize,
    //         height: 113.getSize,
    //       )),
    //     ),
    //     Positioned(
    //       right: -20.getSize,
    //       top: -20.getSize,
    //       child: Container(
    //         width: 320.getSize,
    //         height: 320.getSize,
    //         decoration: BoxDecoration(
    //           gradient: RadialGradient(
    //             center: const Alignment(0.5, -0.6),
    //             radius: 1,
    //             colors: [ColorRes.yellowColor.withOpacity(0.15), ColorRes.transparentColor],
    //           ),
    //         ),
    //       ),
    //     ),
    //     Positioned(
    //       left: -20.getSize,
    //       bottom: -20.getSize,
    //       child: Container(
    //         width: 320.getSize,
    //         height: 320.getSize,
    //         decoration: BoxDecoration(
    //           gradient: RadialGradient(
    //             center: const Alignment(-0.6, 0.8),
    //             radius: 1,
    //             colors: [ColorRes.yellowColor.withOpacity(0.2), ColorRes.transparentColor],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
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
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Utils.getAssetsImg('splash'),width: 84.getSize,height: 80.getSize,),
            7.heightSpacer,
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
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
