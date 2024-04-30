
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:untitled/screens/create_account_module/create_account_model.dart';

import '../../constants/app.export.dart';

class HomeController extends GetxController {

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String? deviceId;
  NewUserModel? user;
  String? selectedLanguage;


  @override
  void onInit() {

    loadLanguage();

    setDeviceId();
    WidgetsBinding.instance.addPostFrameCallback((_) => getUser());
    super.onInit();
  }

  getUser() async {
    try {
      Utils.showCircularProgressLottie(true);
      print('before=================');
      CommonResponse? commonResponse = await DataSource.instance.userGet();
      print('=================after');
      Utils.showCircularProgressLottie(false);

      if (commonResponse != null && commonResponse.status == 200) {

        if(commonResponse.data != null) {
          user = NewUserModel.fromJson(commonResponse.data);

          // Utils.showSuccessToast(commonResponse.message);
        }
        // return true;
      } else {
        if (commonResponse != null && commonResponse.message != null) {
          Utils.showErrToast(commonResponse.message);
        }
      }
    } catch(e) {
      print(e.toString());
    }

    update();
  }

  setDeviceId() async {
    if (Platform.isAndroid) {
      await deviceInfoPlugin.androidInfo.then((value) => deviceId = value.id);
    } else if (Platform.isIOS) {
      await deviceInfoPlugin.iosInfo.then((value) => deviceId = value.identifierForVendor);
    }
    print("============>Device:$deviceId");
    await Injector.setDeviceId(deviceId!);
  }

  loadLanguage() {
    selectedLanguage = Injector.prefs?.getString(PrefKeys.selectedLanguage);
  }

}