import 'package:untitled/screens/home_module/home_view.dart';
import 'package:untitled/screens/kyc_verification_module/kyc_under_review_module/kyc_under_view.dart';
import 'package:untitled/screens/login_module/login_view.dart';
import 'package:untitled/screens/splash_module/splash_view.dart';

import 'constants/app.export.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [
      SystemUiOverlay.bottom,
      SystemUiOverlay.top,
    ],
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Injector.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Palette.primaryMaterialColor,
        scaffoldBackgroundColor: ColorRes.whiteColor,
        primaryColor: ColorRes.primaryColor,
        splashColor: ColorRes.whiteColor,
        appBarTheme: AppBarTheme(
          // brightness: Brightness.dark,
          backgroundColor: ColorRes.whiteColor,
          iconTheme: IconThemeData(color: ColorRes.blackColor),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: ColorRes.primaryColor),
        useMaterial3: true,
      ),
      home: checkForPreviousLogin(),
      navigatorKey: navigatorKey,
      builder: FToastBuilder(),);
  }

  checkForPreviousLogin() {
    return const SplashView();
  }
}