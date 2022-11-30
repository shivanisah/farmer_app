import 'package:agriculture/CollectorPages/Collection_details.dart';
import 'package:agriculture/CollectorPages/Farmers_detail.dart';
import 'package:agriculture/CollectorPages/drawer.dart';
import 'package:agriculture/login.dart';
import 'package:agriculture/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/designcolor.dart';
import '../models/Farmer_profile.dart';


class Collector extends StatefulWidget {
  const Collector({super.key});

  @override
  State<Collector> createState() => _CollectorState();
}

class _CollectorState extends State<Collector> {
  @override
  Widget build(BuildContext context) {
         Color colorWhite = Colors.white;
    //  Color colorPurple = Palette.lightPurple;
         Color colorPurple = Palette.darkBlue;

    Size size= MediaQuery.of(context).size;

    return Scaffold(
      drawer:SideBar(),
      appBar: AppBar(
        title: Text("Collector"),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(
              Icons.logout,
            ),
          )
        ],
      ),
            body: Padding(padding: EdgeInsets.all(10),
      child: Column(
              
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                   padding: const EdgeInsets.only(left:12.0),
                   child: Text('',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    ),
                 ),
                  SizedBox(height: 14,),
                  SingleChildScrollView(
                    
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 5,top: 5),
                      child: Row(
                        children: [
                          
                          GestureDetector(
                            onTap: (){
                                Navigator.pushReplacement(context,
                       MaterialPageRoute(builder: (context) => Farmers_Detail()
                )
              );
                            },
                            child: Container(
                              height: size.height*0.22,
                              width: size.width*0.39,
                              margin: EdgeInsets.only(left: 22),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0,7),
                                            blurRadius: 10,
                                            color:Colors.black.withOpacity(0.3),
                            
                                          )
                                        ]
                                
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  
                                  Icon(Icons.people,color:colorPurple,size:28),
                                  SizedBox(height:5),
                                  Text('Farmers',style: TextStyle(color:Colors.black,fontSize:16))
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
              //               onTap: (){
              //   Navigator.pushReplacement(context,
              //   MaterialPageRoute(builder: (context) => ()
              //   )
              // );

              //               },
                            child: Container(
                              height: size.height*0.22,
                              width: size.width*0.39,
                              margin: EdgeInsets.only(left: 22),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0,7),
                                            blurRadius: 10,
                                            color:Colors.black.withOpacity(0.3),
                            
                                          )
                                        ]
                                
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  
                                  Icon(Icons.people,color:colorPurple,size:28),
                                  SizedBox(height:5),
                                  Text('Collections',style: TextStyle(color:Colors.black,fontSize:16))
                                ],
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                
              ],
            ),),


    );
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('email');
    pref.remove('farmer');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
  
  collectionDetailPage() {}
}
