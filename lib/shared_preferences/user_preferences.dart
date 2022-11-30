

import 'package:shared_preferences/shared_preferences.dart';

// class FarmerPreferences {


//   getUserProfile(List<String> id)async{

//     SharedPreferences pref =await  SharedPreferences.getInstance();

//      pref.setStringList('profile_id', id);
//      pref.setString('email', )

//     pref.commit();
//   }
// }
void updateSharedPrefernces(String id)async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString('email', id);
}
void checkSharedPrefernces(bool check)async{
  SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setBool('farmer', check);
}
void FarmerSharedPrefernces(String id)async{
  SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString('farmer_id', id);
}