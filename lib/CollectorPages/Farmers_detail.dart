import 'dart:async';

import 'package:agriculture/CollectorPages/Collection_details.dart';
import 'package:agriculture/CollectorPages/Profile.dart';
import 'package:agriculture/CollectorPages/drawer.dart';
import 'package:agriculture/login.dart';
import 'package:agriculture/models/collection_detail.dart';
import 'package:agriculture/register.dart';
import 'package:agriculture/shared_preferences/user_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Farmer_profile.dart';


class Farmers_Detail extends StatefulWidget {


  @override
  State<Farmers_Detail> createState() => _Farmers_DetailState();
}

class _Farmers_DetailState extends State<Farmers_Detail> {
  
  // List<String>? uid=[];
  var uid;
  bool _profile=false;
  @override
   getUser()async{
          // print("00000000000000000000000000000");
     setState(){}    
    // dynamic user_id =FirebaseFirestore.instance.collection('users').where('role',isEqualTo:"Farmer").snapshots();
    // // QuerySnapshot<Map<String,dynamic>> User_id = user_id;
    // print(user_id);
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
    print(uid);
   
  }

Widget  getuser(){
                      return
                       StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').where('role',isEqualTo:"Farmer").snapshots(),
          builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){

                      if(snapshot.hasData){
            if(snapshot.data!.docs.length>0){
          return 
          ListView.builder(
            shrinkWrap:true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              var farmerId = snapshot.data!.docs[index];
              String Uid = farmerId.id;
                   
       final _pref = FarmerSharedPrefernces(Uid); 
                            // setState(() {
                            //   uid=Uid;
                            //   print("222222222222222222222");
                            //   print(uid);
                            // });

              return Text(Uid);
            }
            
            );
            
            }
          }
          return Text("");
          }
        );


  }
  

   @override
  void initState(){

           getuser();
            print("00000000000000000000000000000");
              Timer(Duration(seconds: 2), ()=>getUser());
           

    // dynamic user_id =FirebaseFirestore.instance.collection('users').where('role',isEqualTo:"Farmer").snapshots();
    // // QuerySnapshot<Map<String,dynamic>> User_id = user_id;
    // print(user_id);

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer:SideBar(),
      appBar: AppBar(
        title: Text("Farmers Profile"),
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
                body:    Column(
                  children: [
                    getuser(),
      //                                      StreamBuilder(
      //     stream: FirebaseFirestore.instance.collection('users').where('role',isEqualTo:"Farmer").snapshots(),
      //     builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){

      //                 if(snapshot.hasData){
      //       if(snapshot.data!.docs.length>0){
      //     return 
      //     ListView.builder(
      //       shrinkWrap:true,
      //       itemCount: snapshot.data!.docs.length,
      //       itemBuilder: (context,index){
      //         var farmerId = snapshot.data!.docs[index];
      //         String uid = farmerId.id;
                   
      // //  final _pref = FarmerSharedPrefernces(Uid); 
      //           return Text(uid);
      //       }
            
      //       );
            
      //       }
      //     }
      //     return Text("");
      //     }
      //   ),



                             StreamBuilder(
                  stream:FirebaseFirestore.instance.collection('Collection Details').where('userId',isEqualTo:uid).snapshots(),
                  
          builder:(context,AsyncSnapshot snapshot){

          if(snapshot.hasData){
            print(">>>>>>>>>>>>>>..............<<<<<<<<<<<");
            print(uid);
            if(snapshot.data!.docs.length>0){
          return 
          ListView.builder(
            shrinkWrap:true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              var farmerId = snapshot.data!.docs[index];
              // print(farmerId);
              String idd = farmerId.id;
                            print(idd);

              print(uid);
                                                          if(idd!=null){
                                
                                  _profile=true;
                               return Text(idd);           
                              }


              return Text("");
            }
            
            );
            
            }
          }
          return Text("");
          }
        ),








                    Container(
                              padding:EdgeInsets.only(top: 20,right:10),


                    child: 
                    StreamBuilder(
                      stream:FirebaseFirestore.instance.collection('Farmers_profile').snapshots(),
                      builder:(context,AsyncSnapshot snapshot){
                        if(snapshot.hasData){
                          if(snapshot.data.docs.length>0){
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder:(context,index){
                                  profileModel profile = profileModel.fromJson(snapshot.data.docs[index]);

                                  return                 Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                           padding: const EdgeInsets.only(left:18.0),
                          //  child: Text('',
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.w500,
                          //     fontSize: 18,
                          //     color: Colors.black.withOpacity(0.8),
                          //   ),
                          //   ),
                         ),
              SizedBox(height: 2,),
              Padding(
                    padding: const EdgeInsets.only(left:18.0,top:7,right: 4),
                    child: Column(
                      children: [
                        GestureDetector(
                          
                          onTap:(){
                          Navigator.push(context,
                          MaterialPageRoute(
                          builder: (context) => CollectionDetailPage(),
                          settings: RouteSettings(arguments:profile.userId ),
                          // settings: RouteSettings(arguments:collectorId[index] ),


                          )
                          );


                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            height: 62,
                          
                            decoration: BoxDecoration(
                              
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                                   boxShadow: [
                                              BoxShadow(
                                                offset: Offset(0,7),
                                                blurRadius: 10,
                                                color:Colors.black.withOpacity(0.3),
                                
                                              )
                                            ]

                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                              CircleAvatar(backgroundColor:Colors.white,
            backgroundImage:AssetImage('images/agri.jpg'),),

                                  SizedBox(width:20),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                              Text(profile.name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color:   Colors.black.withOpacity(0.8)
                                                ),
                                              ),
                                              Text(profile.permanent_address,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Colors.black.withOpacity(0.8),
                                                ),
                                              ),
                                             Text(profile.phone_number,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Colors.black.withOpacity(0.8),
                                                ),
                                              ),

                                          
                                          ],
                                        ),
                                      ),
                                                                    SizedBox(width: size.width*0.25,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                   _profile?Text('Collected',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Colors.blue,
                                          ),
                                        ):Text('Collect',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Colors.blue,
                                          ),
                                        ),
                                    ],
                                  )

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              )


            ],
          );


                                },
                              );
                          }else{
                            return Center(
                              child:Text("No profile created")
                            );
                          }
                        }
                        return Center(
                            child:CircularProgressIndicator(),
                        );
                      }
                    ),
              ),

              //Streambuilder to get farmers id 

                // getLoggedInUserId(),

                  ],
                ),

    );
  }

   

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
  
  collectionDetailPage() {

  }
}
