import 'package:get_storage/get_storage.dart';


class AppSharedPreference {
  GetStorage? getStorage;

  Future<AppSharedPreference> initializeStorage() async {
    getStorage = GetStorage();
    await GetStorage.init();
    return this;
  }


  final firstTimeLogin = true.val('firstTimeLogin');
  final prefs = ''.val('firstTimeLogin');



  // Create a function to set the user preference.
  Future<void> setUserPreference({String value = "firstTimeLogin"}) async {
   prefs.val = value;
  }

  // Create a function to retrieve the user preference.
  Future<String> getUserPreference() async {
   return prefs.val ;
  }

  void setFirstTimeLogin({bool value = false}) {
    firstTimeLogin.val = value;
  }

  bool getFirstTimeLogin() {
    return firstTimeLogin.val;
  }

  static void clear() {
    final GetStorage storage = GetStorage();
    storage.erase();
  }
}
