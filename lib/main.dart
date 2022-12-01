import 'dart:async';
import 'package:agriculture/UsersPages/Admin.dart';
import 'package:agriculture/UsersPages/Farmer.dart';
import 'package:agriculture/register.dart';
import 'package:agriculture/login.dart';
import 'package:agriculture/spalshScreen.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UsersPages/Collector.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool check =false;
  
  @override
  Widget build(BuildContext context) {
    
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      home:  LoginPage(),
      routes: {
          '/splash' :(context) => SplashScreen(),
          '/collector':(context) => Collector(),
          '/farmer':(context) => Farmer(),
          '/admin':(context) => Admin(),


          '/login':(context) => LoginPage(),
      },
      );
    
  }
}
