import 'package:get_storage/get_storage.dart';

class AirbnbSharePreference {
  GetStorage preference= GetStorage('OCO');

  saveLanguage(String? language){
    preference.write("langue", language);
  }

  saveCurrentUserID(String? userId){
    preference.write("user_id", userId);
  }

  String? getCurrentUserID(){
    return preference.read("user_id");
  }

  saveIsAuthenticated(bool? isAuthenticated){
    preference.write("isAuthenticated", isAuthenticated);
  }

  bool? getIsAuthenticated(){
    return preference.read("isAuthenticated");
  }

  saveNextPageNamed(String? name) {
    preference.write("page", name);
  }

  String? getLanguage(){
    return preference.read("langue");
  }

}