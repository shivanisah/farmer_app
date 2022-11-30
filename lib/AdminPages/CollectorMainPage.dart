// import 'dart:html';

import 'package:agriculture/AdminPages/FarmerMainPage.dart';
import 'package:agriculture/CollectorPages/Profile.dart';
import 'package:agriculture/FarmerPages/Profile.dart';
import 'package:agriculture/UsersPages/Admin.dart';
import 'package:agriculture/login.dart';
import 'package:agriculture/models/CollectorProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../shared_preferences/user_preferences.dart';


class CollectorList extends StatefulWidget {
  // const CollectorList({super.key});

  @override
  State<CollectorList> createState() => _CollectorListState();
}

class _CollectorListState extends State<CollectorList> {
  // var collectorId;
  @override
   void initState(){
    // getCollectorProfile();
    super.initState();
   }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
                  drawer:
      Drawer(
        // width:250,
        backgroundColor:Color.fromARGB(253, 243, 242, 247),
        child:ListView(
          children: [
            UserAccountsDrawerHeader(
              
              accountName: Text("Hello"), accountEmail: Text("MyEmail"),
            currentAccountPicture:CircleAvatar(backgroundColor:Colors.white,
            backgroundImage:AssetImage('images/agri.jpg'))
            ),
             ListTile(
              title:Text('Home',style:TextStyle(color:Colors.black,fontSize:16 )),
              leading:Icon(Icons.home,color:Colors.blue),
              trailing:Icon(Icons.arrow_forward),
              onTap:()=>  Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>Admin()
                )
              )
            ),

            ListTile(
              title:Text('Collectors List',style:TextStyle(color:Colors.black,fontSize:16 )),
              leading:Icon(Icons.people,color:Colors.blue),
              trailing:Icon(Icons.arrow_forward),
              onTap:()=>  Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => CollectorList()
                )
              )
            ),
            ListTile(
              title:Text('Farmers List',style:TextStyle(color:Colors.black,fontSize:16 )),
              leading:Icon(Icons.people,color:Colors.blue),
              trailing:Icon(Icons.arrow_forward),
                onTap:()=>  Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>FarmerList()
                )
              )
            ),
            ListTile(
              title:Text('Log Out',style:TextStyle(color:Colors.black,fontSize:16 )),
              leading:Icon(Icons.logout_rounded,color:Colors.blue),
              onTap:()=> logout(context),
              trailing:Icon(Icons.arrow_forward),


            ),


          ],
        ),
      ),

      appBar: AppBar(
        title: Text("Collectors"),
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
      body:
      Column(
        children: [
          SizedBox(height:20),
          Text("Collectors Logged In Detail"),
          Container(
            padding:EdgeInsets.only(top: 20,right:10),
            child: StreamBuilder(
            stream:FirebaseFirestore.instance.collection('users').where('role',isEqualTo:"collector").snapshots(),

            builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasData){
                if(snapshot.data!.docs.length>0){
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                var   collectorId = snapshot.data!.docs[index];
                  // print(collectorId.id);
                  return          
                   Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                           padding: const EdgeInsets.only(left:18.0),
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
                          builder: (context) => CollectorProfile(),
                          settings: RouteSettings(arguments:collectorId.id ),
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
                                  Container(
                                    width: 60,
                                    
                                    
                                    decoration: BoxDecoration(
                                      // color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage('images/agri.jpg'),)
                                    ),
                                  )
                                  ,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                              Text(collectorId.get('email'),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color:   Colors.black.withOpacity(0.8)
                                                ),
                                              ),
                                              // Text('',
                                              //   style: TextStyle(
                                              //     fontWeight: FontWeight.w500,
                                              //     fontSize: 13,
                                              //     color: Colors.black.withOpacity(0.4),
                                              //   ),
                                              // ),
                                          
                                          ],
                                        ),
                                      ),
                                                                    SizedBox(width: size.width*0.13,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                        Text('Profile',
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

                }
                
                );

                }
   
              }else{
                return Text("Something is wrong");
              }

                return Text("vj");
            }


    ),
          ),
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
}
