import 'package:get/get.dart';

import '../../screen/file_detail_screen.dart';
import '../../screen/folder_data_screen.dart';
import '../../screen/information/pinch_zoom.dart';
import '../../screen/information/private_locker.dart';
import '../../screen/information/splash_screen.dart';
import '../../screen/information/welcome_screen.dart';
import '../../screen/main_screen.dart';
import '../../screen/preview_page.dart';


mixin Routes {
  static const defaultTransition = Transition.rightToLeft;

  static const String splash = "/Splash";
  static const String kMainScreen = "/MainScreen";
  static const String kPinchZoom = "/PinchZoom";
  static const String kPrivateLocker = "/PrivateLocker";
  static const String kFolderDataScreen = "/FolderDataScreen";
  static const String kPreviewPage = "/PreviewPage";
  static const String kFileDetailScreen = "/FileDetailScreen";
  static const String kWelcomeScreen = "/WelcomeScreen";

  static List<GetPage<dynamic>> routes = [
    GetPage<dynamic>(
      name: splash,
      page: () => const SplashScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kWelcomeScreen,
      page: () => const WelcomeScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kPinchZoom,
      page: () => const PinchZoom(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kPrivateLocker,
      page: () => const PrivateLocker(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kMainScreen,
      page: () => const MainScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kFolderDataScreen,
      page: () => const FolderDataScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kPreviewPage,
      page: () => const PreviewPage(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kFileDetailScreen,
      page: () => const FileDetailScreen(),
      transition: defaultTransition,
    ),
    //
  ];
}
