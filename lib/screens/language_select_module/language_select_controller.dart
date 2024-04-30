
import 'package:untitled/constants/app.export.dart';
import 'package:untitled/screens/create_account_module/create_account_view.dart';

import '../intro_module/intro_1_view.dart';
import '../intro_module/intro_3_view.dart';

class LanguageSelectController extends GetxController {

  bool isEnglishSelected = true;

  @override
  onInit() {
    saveSelectedLanguage();
    super.onInit();
  }

  toggleEnglishSelection(bool isSelected) {

    isEnglishSelected = isSelected;
    saveSelectedLanguage();

    update();
  }

  saveSelectedLanguage() {
    String selectedLanguage = 'en';
    if(isEnglishSelected) {
      selectedLanguage = 'en';
    } else {
      selectedLanguage = 'hi';
    }
    Injector.setSelectedLanguage(selectedLanguage);
  }

  goToNextScreen() {
    Utils.transitionWithOff(const Intro1View());
  }

}