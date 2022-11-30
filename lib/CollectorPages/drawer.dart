import 'package:agriculture/CollectorPages/CollectorProfileView.dart';
import 'package:agriculture/CollectorPages/Profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../UsersPages/Collector.dart';
import '../login.dart';
import 'Collection_details.dart';
import 'Farmers_detail.dart';
class SideBar extends StatefulWidget {
      // User currentuser;
      // SideBar(this.currentuser);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  String MyEmail = "";

    @override
  void initState(){

    collector_profile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
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
                MaterialPageRoute(builder: (context) =>Collector()
                )
              )
            ),

            ListTile(
              title:Text('Profile',style:TextStyle(color:Colors.black,fontSize:16 )),
              leading:Icon(Icons.person_add_alt_1_rounded,color:Colors.blue),
              trailing:Icon(Icons.arrow_forward),
              onTap:()=>  Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => CollectorViewProfile()
                )
              )
            ),
            ListTile(
              title:Text('Collections',style:TextStyle(color:Colors.black,fontSize:16 )),
              leading:Icon(Icons.people,color:Colors.blue),
              trailing:Icon(Icons.arrow_forward),
                onTap:()=>  Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>Farmers_Detail()
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
      );

    
    
    
    // Drawer(
    //           // width:250,
    //     backgroundColor:Color.fromARGB(253, 243, 242, 247),
    //     child:ListView(
    //       children: [
    //         UserAccountsDrawerHeader(accountName: Text("Hello"), accountEmail: Text(MyEmail)),
    //       ListTile(
    //           title:Text('Home',style:TextStyle(color:Colors.black,fontSize:20 )),
    //           leading:Icon(Icons.person),
    //           onTap:()=>  Navigator.pushReplacement(context,
    //             MaterialPageRoute(builder: (context) =>Collector()
    //             )
    //           )
    //         ),
    //       ListTile(
    //           title:Text('Profile',style:TextStyle(color:Colors.black,fontSize:20 )),
    //           leading:Icon(Icons.person),
    //           onTap:()=>  Navigator.pushReplacement(context,
    //             MaterialPageRoute(builder: (context) => CollectorProfile()
    //             )
    //           )
    //         ),


    //         ListTile(
    //           title:Text('Collections',style:TextStyle(color:Colors.black,fontSize:16 )),
    //           leading:Icon(Icons.person),
    //           onTap:()=>  Navigator.pushReplacement(context,
    //             MaterialPageRoute(builder: (context) => Farmers_Detail()
    //             )
    //           )
    //         ),
    //         // ListTile(
    //         //   title:Text('Collection Details',style:TextStyle(color:Colors.black,fontSize:20 )),
    //         //   leading:Icon(Icons.person),
    //         //   onTap:()=>  Navigator.pushReplacement(context,
    //         //     MaterialPageRoute(builder: (context) =>CollectionDetailPage()
    //         //     )
    //         //   )
    //         // ),
    //       ],
    //     ),

    // );

    
  }

  collector_profile() async{
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