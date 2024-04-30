
import 'package:get/get.dart';
import 'package:untitled/screens/create_account_module/create_account_controller.dart';
import 'package:untitled/screens/create_account_module/create_account_view.dart';
import 'package:untitled/screens/intro_module/intro_3_view.dart';
import 'package:untitled/screens/login_module/login_view.dart';

import '../../constants/injector.dart';
import '../../constants/utils.dart';
import 'intro_1_view.dart';
import 'intro_2_view.dart';

class IntroController extends GetxController {

  changeLanguage() {
    if(Injector.getSelectedLanguage() == 'en') {
      Injector.setSelectedLanguage('hi');
      Utils.showSuccessToast('Language change to Hindi');
    } else if(Injector.getSelectedLanguage() == 'hi'){
      Injector.setSelectedLanguage('en');
      Utils.showSuccessToast('Language change to English');
    }
  }

  goToIntro3View() {
    Utils.transitionWithTo(const Intro3View());
  }

  goToIntro2View() {
    Utils.transitionWithTo(const Intro2View());
  }

  goToIntro1View() {
    Utils.transitionWithTo(const Intro1View());
  }

  goToCreateAccountView() {
    Utils.transitionWithTo(CreateAccountView(isFromIntro: true, isFromLogin: false, isFromKYC: false,));
  }

  goToBackView() {
    Utils.transitionWithClose(1);
  }

  goToLoginView() {
    Utils.transitionWithTo(LoginView(isFromIntro: true, isFromCreate: false, isFromKYC: false,));
  }

  setIsFirstTime() async{
    await Injector.setIsFirstTime();
  }

}