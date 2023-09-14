class AdsModel {
  String? version;
  String? packageName;
  bool? adProgressDialog;
  bool? adStatus;
  bool? backAd;
  int? dialogTimer;
  bool? showStep;
  bool? splashAd;
  String? splashAdType;
  bool? bot;
  String? botUrl;
  bool? checkVpn;
  int? clickCount;
  int? extraScreen;
  bool? multiNative;
  int? nativeSize;
  bool? onResumeAd;
  bool? installTrack;
  bool? trackType;
  bool? matchTrackUrl;
  bool? smartOrNative;
  List<String>? trackUrl;
  Admob? admob;
  AppLovin? appLovin;
  Facebook? facebook;
  bool? game;
  bool? gameNative;
  int? gameNativeSize;
  List<String>? gameNativeUrl;
  List<String>? gameUrl;
  CustomAdData? customAdData;
  ExtraData? extraData;
  TrackData? trackData;
  String? privacyPolicy;
  bool? redirectApp;
  String? redirectAppLink;
  bool? showCustomAd;
  ShowScreen? showScreen;
  bool? targetArea;
  List<String>? targetCity;
  List<String>? targetCountry;
  List<String>? targetState;

  AdsModel(
      {this.version,
      this.packageName,
      this.adProgressDialog,
      this.adStatus,
      this.backAd,
      this.dialogTimer,
      this.showStep,
      this.splashAd,
      this.splashAdType,
      this.bot,
      this.botUrl,
      this.checkVpn,
      this.smartOrNative,
      this.clickCount,
      this.extraScreen,
      this.multiNative,
      this.nativeSize,
      this.onResumeAd,
      this.trackType,
      this.trackUrl,
      this.installTrack,
      this.matchTrackUrl,
      this.admob,
      this.appLovin,
      this.trackData,
      this.facebook,
      this.game,
      this.gameNative,
      this.gameNativeSize,
      this.gameNativeUrl,
      this.gameUrl,
      this.customAdData,
      this.extraData,
      this.privacyPolicy,
      this.redirectApp,
      this.redirectAppLink,
      this.showCustomAd,
      this.showScreen,
      this.targetArea,
      this.targetCity,
      this.targetCountry,
      this.targetState});

  AdsModel.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    packageName = json['package_name'];
    adProgressDialog = json['ad_progress_dialog'];
    adStatus = json['ad_status'];
    backAd = json['back_ad'];
    dialogTimer = json['dialog_timer'];
    showStep = json['show_step'];
    splashAd = json['splash_ad'];
    splashAdType = json['splash_ad_type'];
    bot = json['bot'];
    botUrl = json['bot_url'];
    checkVpn = json['check_vpn'];
    clickCount = json['click_count'];
    extraScreen = json['extra_screen'];
    multiNative = json['multi_native'];
    nativeSize = json['native_size'];
    onResumeAd = json['on_resume_ad'];
    installTrack = json['install_track'];
    smartOrNative = json['smart_or_native'];
    matchTrackUrl = json['match_track_url'];
    trackType = json['track_type'];
    trackUrl = json['track_url'].cast<String>();
    admob = json['admob'] != null ? new Admob.fromJson(json['admob']) : null;
    appLovin = json['app_lovin'] != null ? new AppLovin.fromJson(json['app_lovin']) : null;
    facebook = json['facebook'] != null ? new Facebook.fromJson(json['facebook']) : null;
    game = json['game'];
    gameNative = json['game_native'];
    gameNativeSize = json['game_native_size'];
    gameNativeUrl = json['game_native_url'].cast<String>();
    gameUrl = json['game_url'].cast<String>();
    customAdData = json['custom_ad_data'] != null ? new CustomAdData.fromJson(json['custom_ad_data']) : null;
    extraData = json['extra_data'] != null ? new ExtraData.fromJson(json['extra_data']) : null;
    trackData = json['track_data'] != null ? new TrackData.fromJson(json['track_data']) : null;
    privacyPolicy = json['privacy_policy'];
    redirectApp = json['redirect_app'];
    redirectAppLink = json['redirect_app_link'];
    showCustomAd = json['show_custom_ad'];
    showScreen = json['show_screen'] != null ? new ShowScreen.fromJson(json['show_screen']) : null;
    targetArea = json['target_area'];
    targetCity = json['target_city'].cast<String>();
    targetCountry = json['target_country'].cast<String>();
    targetState = json['target_state'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = version;
    data['package_name'] = packageName;
    data['ad_progress_dialog'] = adProgressDialog;
    data['ad_status'] = adStatus;
    data['back_ad'] = backAd;
    data['dialog_timer'] = dialogTimer;
    data['show_step'] = showStep;
    data['splash_ad'] = splashAd;
    data['splash_ad_type'] = splashAdType;
    data['bot'] = bot;
    data['bot_url'] = botUrl;
    data['check_vpn'] = checkVpn;
    data['click_count'] = clickCount;
    data['extra_screen'] = extraScreen;
    data['multi_native'] = multiNative;
    data['native_size'] = nativeSize;
    data['on_resume_ad'] = onResumeAd;
    data['install_track'] = installTrack;
    data['smart_or_native'] = smartOrNative;
    data['track_type'] = trackType;
    data['match_track_url'] = matchTrackUrl;
    data['track_url'] = trackUrl;
    if (admob != null) {
      data['admob'] = admob!.toJson();
    }
    if (appLovin != null) {
      data['app_lovin'] = appLovin!.toJson();
    }
    if (facebook != null) {
      data['facebook'] = facebook!.toJson();
    }
    data['game'] = game;
    data['game_native'] = gameNative;
    data['game_native_size'] = gameNativeSize;
    data['game_native_url'] = gameNativeUrl;
    data['game_url'] = gameUrl;
    if (customAdData != null) {
      data['custom_ad_data'] = customAdData!.toJson();
    }
    if (extraData != null) {
      data['extra_data'] = extraData!.toJson();
    }
    if (trackData != null) {
      data['track_data'] = trackData!.toJson();
    }
    data['privacy_policy'] = privacyPolicy;
    data['redirect_app'] = redirectApp;
    data['redirect_app_link'] = redirectAppLink;
    data['show_custom_ad'] = showCustomAd;
    if (showScreen != null) {
      data['show_screen'] = showScreen!.toJson();
    }
    data['target_area'] = targetArea;
    data['target_city'] = targetCity;
    data['target_country'] = targetCountry;
    data['target_state'] = targetState;
    return data;
  }
}

class Admob {
  List<String>? admobBanner;
  List<String>? admobInter;
  List<String>? admobNative;
  List<String>? admobAppopen;
  List<String>? admobReward;

  Admob({this.admobBanner, this.admobInter, this.admobNative, this.admobAppopen, this.admobReward});

  Admob.fromJson(Map<String, dynamic> json) {
    admobBanner = json['admob_banner'].cast<String>();
    admobInter = json['admob_inter'].cast<String>();
    admobNative = json['admob_native'].cast<String>();
    admobAppopen = json['admob_appopen'].cast<String>();
    admobReward = json['admob_reward'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admob_banner'] = admobBanner;
    data['admob_inter'] = admobInter;
    data['admob_native'] = admobNative;
    data['admob_appopen'] = admobAppopen;
    data['admob_reward'] = admobReward;
    return data;
  }
}

class AppLovin {
  List<String>? lovinNative;
  List<String>? lovinInter;
  List<String>? lovinAppopen;
  List<String>? lovinBanner;
  List<String>? lovinReward;

  AppLovin({this.lovinNative, this.lovinInter, this.lovinAppopen, this.lovinBanner, this.lovinReward});

  AppLovin.fromJson(Map<String, dynamic> json) {
    lovinNative = json['lovin_native'].cast<String>();
    lovinInter = json['lovin_inter'].cast<String>();
    lovinAppopen = json['lovin_appopen'].cast<String>();
    lovinBanner = json['lovin_banner'].cast<String>();
    lovinReward = json['lovin_reward'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lovin_native'] = lovinNative;
    data['lovin_inter'] = lovinInter;
    data['lovin_appopen'] = lovinAppopen;
    data['lovin_banner'] = lovinBanner;
    data['lovin_reward'] = lovinReward;
    return data;
  }
}

class Facebook {
  List<String>? fbNative;
  List<String>? fbBanner;
  List<String>? fbInter;
  List<String>? fbReward;

  Facebook({this.fbNative, this.fbBanner, this.fbInter, this.fbReward});

  Facebook.fromJson(Map<String, dynamic> json) {
    fbNative = json['fb_native'].cast<String>();
    fbBanner = json['fb_banner'].cast<String>();
    fbInter = json['fb_inter'].cast<String>();
    fbReward = json['fb_reward'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fb_native'] = fbNative;
    data['fb_banner'] = fbBanner;
    data['fb_inter'] = fbInter;
    data['fb_reward'] = fbReward;
    return data;
  }
}

class CustomAdData {
  String? appName;
  String? buttonName;
  String? packageName;
  String? logo;
  String? banner;
  String? shortDesc;

  CustomAdData({this.appName, this.buttonName, this.packageName, this.logo, this.banner, this.shortDesc});

  CustomAdData.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    buttonName = json['button_name'];
    packageName = json['package_name'];
    logo = json['logo'];
    banner = json['banner'];
    shortDesc = json['short_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_name'] = appName;
    data['button_name'] = buttonName;
    data['package_name'] = packageName;
    data['logo'] = logo;
    data['banner'] = banner;
    data['short_desc'] = shortDesc;
    return data;
  }
}

class ExtraData {
  bool? adStatus;
  bool? game;
  bool? showStep;
  String? splashAdType;
  Facebook? facebook;
  int? clickCount;
  int? extraScreen;
  bool? multiNative;
  bool? onResumeAd;
  bool? adProgressDialog;
  bool? installTrack;
  bool? trackType;
  bool? matchTrackUrl;
  bool? smartOrNative;
  List<String>? trackUrl;
  ShowScreen? showScreen;
  List<String>? gameUrl;
  AppLovin? appLovin;
  int? nativeSize;
  bool? splashAd;
  bool? backAd;
  Admob? admob;
  bool? gameNative;
  int? gameNativeSize;
  List<String>? gameNativeUrl;

  ExtraData(
      {this.adStatus,
      this.game,
      this.showStep,
      this.splashAdType,
      this.facebook,
      this.clickCount,
      this.extraScreen,
      this.multiNative,
      this.onResumeAd,
      this.adProgressDialog,
      this.trackType,
      this.trackUrl,
      this.installTrack,
      this.smartOrNative,
      this.matchTrackUrl,
      this.showScreen,
      this.gameUrl,
      this.appLovin,
      this.nativeSize,
      this.splashAd,
      this.backAd,
      this.admob,
      this.gameNative,
      this.gameNativeSize,
      this.gameNativeUrl});

  ExtraData.fromJson(Map<String, dynamic> json) {
    adStatus = json['ad_status'];
    game = json['game'];
    showStep = json['show_step'];
    splashAdType = json['splash_ad_type'];
    facebook = json['facebook'] != null ? new Facebook.fromJson(json['facebook']) : null;
    clickCount = json['click_count'];
    extraScreen = json['extra_screen'];
    multiNative = json['multi_native'];
    onResumeAd = json['on_resume_ad'];
    adProgressDialog = json['ad_progress_dialog'];
    installTrack = json['install_track'];
    smartOrNative = json['smart_or_native'];
    trackType = json['track_type'];
    matchTrackUrl = json['match_track_url'];
    trackUrl = json['track_url'].cast<String>();
    showScreen = json['show_screen'] != null ? new ShowScreen.fromJson(json['show_screen']) : null;
    gameUrl = json['game_url'].cast<String>();
    appLovin = json['app_lovin'] != null ? new AppLovin.fromJson(json['app_lovin']) : null;
    nativeSize = json['native_size'];
    splashAd = json['splash_ad'];
    backAd = json['back_ad'];
    admob = json['admob'] != null ? new Admob.fromJson(json['admob']) : null;
    gameNative = json['game_native'];
    gameNativeSize = json['game_native_size'];
    gameNativeUrl = json['game_native_url'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ad_status'] = adStatus;
    data['game'] = game;
    data['show_step'] = showStep;
    data['splash_ad_type'] = splashAdType;
    if (facebook != null) {
      data['facebook'] = facebook!.toJson();
    }
    data['click_count'] = clickCount;
    data['extra_screen'] = extraScreen;
    data['multi_native'] = multiNative;
    data['on_resume_ad'] = onResumeAd;
    data['install_track'] = installTrack;
    data['smart_or_native'] = smartOrNative;
    data['track_type'] = trackType;
    data['match_track_url'] = matchTrackUrl;
    data['track_url'] = trackUrl;
    data['ad_progress_dialog'] = adProgressDialog;
    if (showScreen != null) {
      data['show_screen'] = showScreen!.toJson();
    }
    data['game_url'] = gameUrl;
    if (appLovin != null) {
      data['app_lovin'] = appLovin!.toJson();
    }
    data['native_size'] = nativeSize;
    data['splash_ad'] = splashAd;
    data['back_ad'] = backAd;
    if (admob != null) {
      data['admob'] = admob!.toJson();
    }
    data['game_native'] = gameNative;
    data['game_native_size'] = gameNativeSize;
    data['game_native_url'] = gameNativeUrl;
    return data;
  }
}

class TrackData {
  bool? adStatus;
  bool? game;
  bool? showStep;
  String? splashAdType;
  Facebook? facebook;
  int? clickCount;
  int? extraScreen;
  bool? multiNative;
  bool? onResumeAd;
  bool? adProgressDialog;
  bool? smartOrNative;
  ShowScreen? showScreen;
  List<String>? gameUrl;
  AppLovin? appLovin;
  int? nativeSize;
  bool? splashAd;
  bool? backAd;
  Admob? admob;
  bool? gameNative;
  int? gameNativeSize;
  List<String>? gameNativeUrl;

  TrackData(
      {this.adStatus,
      this.game,
      this.showStep,
      this.splashAdType,
      this.facebook,
      this.clickCount,
      this.extraScreen,
      this.multiNative,
      this.onResumeAd,
      this.smartOrNative,
      this.adProgressDialog,
      this.showScreen,
      this.gameUrl,
      this.appLovin,
      this.nativeSize,
      this.splashAd,
      this.backAd,
      this.admob,
      this.gameNative,
      this.gameNativeSize,
      this.gameNativeUrl});

  TrackData.fromJson(Map<String, dynamic> json) {
    adStatus = json['ad_status'];
    game = json['game'];
    showStep = json['show_step'];
    splashAdType = json['splash_ad_type'];
    facebook = json['facebook'] != null ? new Facebook.fromJson(json['facebook']) : null;
    clickCount = json['click_count'];
    extraScreen = json['extra_screen'];
    smartOrNative = json['smart_or_native'];
    multiNative = json['multi_native'];
    onResumeAd = json['on_resume_ad'];
    adProgressDialog = json['ad_progress_dialog'];
    showScreen = json['show_screen'] != null ? new ShowScreen.fromJson(json['show_screen']) : null;
    gameUrl = json['game_url'].cast<String>();
    appLovin = json['app_lovin'] != null ? new AppLovin.fromJson(json['app_lovin']) : null;
    nativeSize = json['native_size'];
    splashAd = json['splash_ad'];
    backAd = json['back_ad'];
    admob = json['admob'] != null ? new Admob.fromJson(json['admob']) : null;
    gameNative = json['game_native'];
    gameNativeSize = json['game_native_size'];
    gameNativeUrl = json['game_native_url'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ad_status'] = adStatus;
    data['game'] = game;
    data['show_step'] = showStep;
    data['splash_ad_type'] = splashAdType;
    if (facebook != null) {
      data['facebook'] = facebook!.toJson();
    }
    data['click_count'] = clickCount;
    data['extra_screen'] = extraScreen;
    data['multi_native'] = multiNative;
    data['on_resume_ad'] = onResumeAd;
    data['ad_progress_dialog'] = adProgressDialog;
    if (showScreen != null) {
      data['show_screen'] = showScreen!.toJson();
    }
    data['game_url'] = gameUrl;
    if (appLovin != null) {
      data['app_lovin'] = appLovin!.toJson();
    }
    data['native_size'] = nativeSize;
    data['splash_ad'] = splashAd;
    data['smart_or_native'] = smartOrNative;
    data['back_ad'] = backAd;
    if (admob != null) {
      data['admob'] = admob!.toJson();
    }
    data['game_native'] = gameNative;
    data['game_native_size'] = gameNativeSize;
    data['game_native_url'] = gameNativeUrl;
    return data;
  }
}

class ShowScreen {
  bool? b1;
  bool? b2;
  bool? b3;
  bool? b4;
  bool? b5;
  bool? b6;

  ShowScreen({this.b1, this.b2, this.b3, this.b4, this.b5, this.b6});

  ShowScreen.fromJson(Map<String, dynamic> json) {
    b1 = json['1'];
    b2 = json['2'];
    b3 = json['3'];
    b4 = json['4'];
    b5 = json['5'];
    b6 = json['6'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = b1;
    data['2'] = b2;
    data['3'] = b3;
    data['4'] = b4;
    data['5'] = b5;
    data['6'] = b6;
    return data;
  }
}
