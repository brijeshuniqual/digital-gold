
import 'dart:async';

import 'package:untitled/constants/app.export.dart';
import 'package:untitled/screens/intro_module/intro_3_view.dart';
import 'package:untitled/screens/language_select_module/language_select_view.dart';

import '../home_module/home_view.dart';

class SplashController extends GetxController {

  @override
  void onInit() {

    String? token = Injector.prefs?.getString(PrefKeys.accessToken);
    bool? isUserVerified = Injector.prefs?.getBool(PrefKeys.isUserVerified);

    print(token);
    print(isUserVerified);
    Timer(
      const Duration(seconds: 2),
          () {
        print("object");
        if(Injector.prefs?.getBool(PrefKeys.isFirstTime) == null) {
          Utils.transitionWithOff(const LanguageSelectView());
        } else {
          if(token != null &&  isUserVerified == true) {
            Utils.transitionWithOff(const HomeView());
          } else {
            Utils.transitionWithOff(const Intro3View());
          }
        }
      },
    );
    super.onInit();

  }


}