import 'package:get/get.dart';
import '../../screen/favorites_screen.dart';
import '../../screen/file_detail_screen.dart';
import '../../screen/folder_data_screen.dart';
import '../../screen/information/duplicate_screen.dart';
import '../../screen/information/insta.dart';
import '../../screen/information/pinch_zoom.dart';
import '../../screen/information/private_locker.dart';
import '../../screen/information/splash_screen.dart';
import '../../screen/information/welcome_screen.dart';
import '../../screen/main_screen.dart';
import '../../screen/photo_edit.dart';
import '../../screen/preview_page.dart';
import '../../screen/private_safe.dart';
import '../../screen/recycle _bin.dart';


mixin Routes {
  static const defaultTransition = Transition.rightToLeft;

  static const String splash = "/Splash";
  static const String kMainScreen = "/MainScreen";
  static const String kPinchZoom = "/PinchZoom";
  static const String kPhotoEdit = "/PhotoEdit";
  static const String kPrivateLocker = "/PrivateLocker";
  static const String kDuplicateScreen = "/Duplicate_Screen";
  static const String kFolderDataScreen = "/FolderDataScreen";
  static const String kPreviewPage = "/PreviewPage";
  static const String kFavoritesScreen = "/Favorites_Screen";
  static const String kRecycleBin = "/Recycle_Bin";
  static const String kInsta = "/Insta";
  static const String kPrivateSafe = "/Private_Safe";
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
      name: kFavoritesScreen,
      page: () => const Favorites_Screen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kRecycleBin,
      page: () => const Recycle_Bin(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kPrivateSafe,
      page: () => const Private_Safe(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kInsta,
      page: () => const Insta(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kDuplicateScreen,
      page: () => const Duplicate_Screen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kPhotoEdit,
      page: () => const PhotoEdit(),
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
