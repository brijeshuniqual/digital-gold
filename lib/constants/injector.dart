import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/screens/create_account_module/create_account_model.dart';
import 'app.export.dart';


class Injector {
  static Injector? _instance;
  static String? email;
  static bool isDarkMode = false;
  static FirebaseMessaging? firebaseMessaging;
  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static DeviceInfoPlugin? deviceInfo = DeviceInfoPlugin();
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static GoogleSignIn googleSignIn = GoogleSignIn();


  // static FacebookAuth facebookAuth = FacebookAuth.instance;

  //OBJECTS
  static SharedPreferences? prefs;
  static int? userId;

  // static UserModel? userData;
  static int notificationID = 0;

  factory Injector() {
    return _instance ?? Injector._internal();
  }

  Injector._internal() {
    _instance = this;
  }

  static Injector get shared => Injector();

  static getInstance() async {
    prefs = await SharedPreferences.getInstance();
    flutterLocalNotificationsPlugin?.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    // await Firebase.initializeApp();
    // firebaseMessaging = FirebaseMessaging.instance;

    // if (prefs?.getString(PrefKeys.userData) != null) {
    //   userData = UserModel.fromJson(jsonDecode(prefs.getString(PrefKeys.userData)));
    //   userId = userData.id;
    // }
  }

  // static GoogleSignIn googleSignIn = GoogleSignIn(
  //   scopes: <String>[
  //     'email',
  //     'profile',
  //   ],
  // );

  // static setUserData(UserModel userModel,{bool isFromEditProfile = false}) async {
  //   // update profile ma userdata ma token same j rese but login ma change thay jase e condition add karvani che
  //   if(userData != null && userData?.authentication != null && isFromEditProfile) {
  //     Authentication? auth = userData?.authentication;
  //     userModel.authentication = auth;
  //   }
  //   prefs!.setString(PrefKeys.userData, jsonEncode(userModel.toJson()));
  //   userData = userModel;
  //   userId = userData?.id;
  // }

  // static getUserData() {
  //   return UserModel.fromJson(jsonDecode(prefs.getString(PrefKeys.userData)));
  // }

  static setDeviceId(String id) async {
    prefs!.setString(PrefKeys.deviceId, id);
  }

  static getDeviceId() async {
    return prefs!.getString(PrefKeys.deviceId);
  }

  static setAccessToken(String id) async {
    prefs!.setString(PrefKeys.accessToken, id);
  }

  static setProviderType(String providerType) async {
    prefs!.setString(PrefKeys.providerType, providerType);
  }

  static getProviderType() async {
    return prefs!.getString(PrefKeys.providerType);
  }

  static getAccessToken() async {
    return prefs!.getString(PrefKeys.accessToken);
  }

  static setSelectedLanguage(String selectedLanguage) async{
    prefs!.setString(PrefKeys.selectedLanguage, selectedLanguage);
  }

  static String? getSelectedLanguage() {
    String? selectedLanguage = prefs!.getString(PrefKeys.selectedLanguage);
    return selectedLanguage;
  }

  static setUserData(NewUserModel u) async{
    prefs!.setString(PrefKeys.userData, jsonEncode(u.toJson()));
  }

  static Future<NewUserModel> getUserData() async{
    NewUserModel userData = NewUserModel();
    String? userdataString = prefs!.getString(PrefKeys.userData);
    if(userdataString != null) {
      var json = jsonDecode(userdataString!);
      NewUserModel userData = NewUserModel.fromJson(json);
    }
    return userData;
  }

  static setEmail(String email) async{
    prefs!.setString(PrefKeys.email, email);
  }

  static String? getEmail() {
    String? email = prefs!.getString(PrefKeys.email);
    return email;
  }

  static setIsFirstTime() async{
    prefs!.setBool(PrefKeys.isFirstTime, false);
  }

  static setIsUserVerified(bool isUserVerified) async{
    prefs!.setBool(PrefKeys.isUserVerified, isUserVerified);
  }

}
