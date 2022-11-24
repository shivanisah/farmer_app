

import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {


  getUserProfile(String id)async{

    SharedPreferences pref =await  SharedPreferences.getInstance();

     pref.setString('profile_id', id);

    pref.commit();
  }
}