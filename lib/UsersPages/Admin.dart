// import 'dart:html';

import 'package:agriculture/AdminPages/CollectorMainPage.dart';
import 'package:agriculture/AdminPages/CollectorProfileList.dart';
import 'package:agriculture/AdminPages/FarmerMainPage.dart';
import 'package:agriculture/AdminPages/FarmerProfileList.dart';
import 'package:agriculture/AdminPages/Noprofile.dart';
import 'package:agriculture/CollectorPages/Farmers_detail.dart';
import 'package:agriculture/CollectorPages/Profile.dart';
import 'package:agriculture/FarmerPages/Profile.dart';
import 'package:agriculture/Widgets/designcolor.dart';
import 'package:agriculture/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Admin extends StatefulWidget {
  // const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
      String MyEmail="";

  @override
   void initState(){
    farmer_profile();
    super.initState();
   }
  @override
  Widget build(BuildContext context) {
     Color colorWhite = Colors.white;
    //  Color colorPurple = Palette.lightPurple;
         Color colorPurple = Palette.darkBlue;

    Size size= MediaQuery.of(context).size;
    return Scaffold(
            drawer:
      Drawer(
        // width:250,
        backgroundColor:Color.fromARGB(253, 243, 242, 247),
        child:ListView(
          children: [
            UserAccountsDrawerHeader(
              
              accountName: Text("Hello"), accountEmail: Text(MyEmail),
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
        // backgroundColor: Color(0xD2A10C),
        title: Text("Admin"),
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
      child: SingleChildScrollView(
      scrollDirection: Axis.vertical,

        child: Column(
                
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Padding(
                     padding: const EdgeInsets.only(left:12.0),
                     child: Text('Categories',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black.withOpacity(0.8),
                      ),
                      ),
                   ),
                    SizedBox(height: 14,),
                    // Consumer<StaffProvider>(
                    //   builder: (context, provider, child) {
                    //     final itemss = provider.jobCategory();
                    //     print(provider);
                    //     return Text('data');
                        
                    //   },
                    // ),
                    SingleChildScrollView(
                      
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 5,top: 5),
                        child: Row(
                          children: [
                            
                            GestureDetector(
                              onTap: (){
                                  Navigator.pushReplacement(context,
                         MaterialPageRoute(builder: (context) => CollectorList()
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
                                    Text('Collectors',style: TextStyle(color:Colors.black,fontSize:16))
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                  Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => FarmerList()
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
                            
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height:20),
                    Padding(
                        padding: EdgeInsets.only(bottom: 5,top: 5),
                        child: Row(
                          children: [
                            
                            GestureDetector(
                              onTap: (){
                //                   Navigator.pushReplacement(context,
                //          MaterialPageRoute(builder: (context) => CollectorList()
                //   )
                // );
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
                                    Text('Assignments',style: TextStyle(color:Colors.black,fontSize:16))
                                  ],
                                ),
                              ),
                            ),
                //             GestureDetector(
                //               onTap: (){
                //   Navigator.pushReplacement(context,
                //   MaterialPageRoute(builder: (context) => CollectorNoprofile()
                //   )
                // );
      
                //               },
                //               child: Container(
                //                 height: size.height*0.22,
                //                 width: size.width*0.39,
                //                 margin: EdgeInsets.only(left: 22),
                //                 decoration: BoxDecoration(
                //                   color: Colors.white,
                //                   borderRadius: BorderRadius.circular(10),
                //                   boxShadow: [
                //                             BoxShadow(
                //                               offset: Offset(0,7),
                //                               blurRadius: 10,
                //                               color:Colors.black.withOpacity(0.3),
                              
                //                             )
                //                           ]
                                  
                //                 ),
                //                 child: Column(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   crossAxisAlignment: CrossAxisAlignment.center,
                //                   children: [
                                    
                //                     Icon(Icons.people,color:colorPurple,size:28),
                //                     SizedBox(height:5),
                //                     Text('Farmers',style: TextStyle(color:Colors.black,fontSize:16))
                //                   ],
                //                 ),
                //               ),
                //             ),
                            
                          ],
                        ),
                      ),
      
                  
                ],
              ),
      ),),

    );
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
        SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('email');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
 farmer_profile() async{
      User? user =await  FirebaseAuth.instance.currentUser;
       await  FirebaseFirestore.instance.collection('users').doc(user!.uid).get().
            then((DocumentSnapshot documentSnapshot){
                          if(documentSnapshot.exists){
                         var myEmail=documentSnapshot.get("email");
                              setState(() {
                              MyEmail= myEmail;
                            });

                            print(".........................................");
                            print(MyEmail);
                                                }
                                                }
                                           
    );

  }

}
