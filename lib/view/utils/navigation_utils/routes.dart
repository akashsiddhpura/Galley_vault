import 'package:get/get.dart';

import '../../screen/MainPage/Albums/Edit Photo/photo_edit.dart';
import '../../screen/MainPage/Albums/Favorite/favorite_videos_page.dart';
import '../../screen/MainPage/Albums/FileDetail/file_detail_screen.dart';
import '../../screen/MainPage/Albums/Folder/folder_data_screen.dart';
import '../../screen/MainPage/Albums/Preview/preview_page.dart';
import '../../screen/MainPage/Albums/Preview/preview_page_2.dart';
import '../../screen/MainPage/All Media/image_selection_screen.dart';
import '../../screen/MainPage/Explore/InastaGrid/instagride_screen.dart';
import '../../screen/MainPage/Explore/explore_screen.dart';
import '../../screen/MainPage/Explore/private_safe/confirm_pin.dart';
import '../../screen/MainPage/Explore/private_safe/confirmpin2.dart';
import '../../screen/MainPage/Explore/private_safe/private_photo.dart';
import '../../screen/MainPage/Explore/private_safe/private_safe.dart';
import '../../screen/MainPage/Explore/private_safe/security_screen.dart';
import '../../screen/MainPage/Setting/feedback.dart';
import '../../screen/MainPage/Setting/instructions.dart';
import '../../screen/MainPage/Setting/setting_screen.dart';
import '../../screen/MainPage/main_screen.dart';

import '../../screen/MainPage/substitution/substitution_screen.dart';
import '../../screen/VideoPlayer/video_screen.dart';
import '../../screen/information/duplicate_screen.dart';
import '../../screen/information/insta.dart';
import '../../screen/information/pinch_zoom.dart';
import '../../screen/information/private_locker.dart';
import '../../screen/information/splash_screen.dart';
import '../../screen/information/welcome_screen.dart';

mixin Routes {
  static const defaultTransition = Transition.rightToLeft;

  static const String splash = "/Splash";
  static const String kMainScreen = "/MainScreen";
  static const String kPinchZoom = "/PinchZoom";
  static const String kPhotoEdit = "/PhotoEdit";
  static const String kPrivateLocker = "/PrivateLocker";
  static const String kDuplicateScreen = "/Duplicate_Screen";
  static const String kFolderDataScreen = "/FolderDataScreen";
  static const String kSecurityScreen = "/SecurityScreen";
  static const String kPreviewPage = "/PreviewPage";
  static const String kPriviewPage2 = "/PriviewPage2";
  static const String kFavoritesScreen = "/Favorites_Screen";
  static const String kRecycleBin = "/Recycle_Bin";
  static const String kConfirmPin = "/ConfirmPin";
  static const String kConfirmPin2 = "/ConfirmPin2";
  static const String kPrivatePhoto = "/PrivatePhoto";
  static const String kInsta = "/Insta";
  static const String kSubStitution = "/SubStitution";
  static const String kExplore_Screen = "/Explore_Screen";
  static const String kVideoScreen = "/VideoScreen";
  static const String kPrivateSafe = "/Private_Safe";
  static const String kFileDetailScreen = "/FileDetailScreen";
  static const String kWelcomeScreen = "/WelcomeScreen";
  static const String kInstaGrideScreen = "/InstaGrideScreen";
  static const String kImageSelectionScreen = "/ImageSelectionScreen";
  static const String kInstructionsScreen = "/InstructionsScreen";
  static const String kSendFeedbackScreen = "/SendFeedbackScreen";
  static const String kSettingScreen = "/Setting_Screen";

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
    ),    GetPage<dynamic>(
      name: kSendFeedbackScreen,
      page: () => const SendFeedbackScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kPrivatePhoto,
      page: () => const PrivatePhoto(),
      transition: defaultTransition,
    ),    GetPage<dynamic>(
      name: kSettingScreen,
      page: () => const Setting_Screen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kFavoritesScreen,
      page: () => FavouriteScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kRecycleBin,
      page: () => const Setting_Screen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kSubStitution,
      page: () => const SubStitution(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kConfirmPin,
      page: () => const ConfirmPin(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kInstructionsScreen,
      page: () => const InstructionsScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kConfirmPin2,
      page: () =>  const ConfirmPin2(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kExplore_Screen,
      page: () => const Explore_Screen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kSecurityScreen,
      page: () => const SecurityScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kPrivateSafe,
      page: () => const Private_Safe(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kVideoScreen,
      page: () => const VideoScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kInsta,
      page: () => const Insta(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kInstaGrideScreen,
      page: () => InstaGrideScreen(),
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
      name: kPriviewPage2,
      page: () => PriviewPage2(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kFileDetailScreen,
      page: () => const FileDetailScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: kImageSelectionScreen,
      page: () => const ImageSelectionScreen(),
      transition: defaultTransition,
    ),
    //
  ];
}
