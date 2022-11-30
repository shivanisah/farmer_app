import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    Timer(Duration(seconds: 2),()=>getUser());
    super.initState();

  }
  getUser()async{
    SharedPreferences pref  = await SharedPreferences.getInstance();

    var email = pref.getString('email');
    var isfarmer= pref.getBool('farmer');
    if(email!=null && isfarmer==false){
     Navigator.pushReplacementNamed(context, '/farmer');
      // check=true;
    }
   else     if(email!=null && isfarmer==true){
     Navigator.pushReplacementNamed(context, '/collector');
      // check=true;
    }
    else    if(email!=null ){
     Navigator.pushReplacementNamed(context, '/admin');
      // check=true;
    }


    else{
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
    );
  }
}