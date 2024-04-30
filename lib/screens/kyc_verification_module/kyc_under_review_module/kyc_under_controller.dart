
import 'dart:async';

import 'package:get/get.dart';

import '../../../constants/utils.dart';
import '../../home_module/home_view.dart';

class KYCUnderController extends GetxController {

  @override
  void onInit() {

    Timer(
      const Duration(seconds: 2),
          () {
        print("Home View");
        Utils.transitionWithClose(1);
        Utils.transitionWithOffAll(const HomeView());
      },
    );

    super.onInit();
  }
}