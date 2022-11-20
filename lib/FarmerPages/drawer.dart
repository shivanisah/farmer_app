import 'package:agriculture/CollectorPages/Profile.dart';
import 'package:agriculture/FarmerPages/Profile.dart';
import 'package:agriculture/FarmerPages/ViewProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../UsersPages/Collector.dart';
import '../UsersPages/Farmer.dart';
class FarmerMenu extends StatefulWidget {
  User user;
    
    FarmerMenu(this.user);
  
  @override
  State<FarmerMenu> createState() => _FarmerMenuState();
}

class _FarmerMenuState extends State<FarmerMenu> {
  String myEmail = "";

  @override
  Widget build(BuildContext context) {
    return  Drawer(
        width:250,
        backgroundColor:Color.fromARGB(253, 243, 242, 247),
        child:ListView(
          children: [
            // FutureBuilder(
            //   future:farmer_profile(),
            //   builder:(context,snapshot){
            //     if(snapshot.connectionState!=ConnectionState.done)
            //       return Text("Loading data....Please wait");
            //     return Text("Email: $myEmail");  
            //   },
            // ),
            UserAccountsDrawerHeader(accountName: Text("Hello"), accountEmail: Text(myEmail)),
            // farmer_profile(profile);
          ListTile(
              title:Text('Home',style:TextStyle(color:Colors.black,fontSize:20 )),
              leading:Icon(Icons.person),
              onTap:()=>  Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>Farmer(widget.user)
                )
              )
            ),

            ListTile(
              title:Text('Profile',style:TextStyle(color:Colors.black,fontSize:20 )),
              leading:Icon(Icons.person),
              // onTap:()=>  Navigator.pushReplacement(context,
              //   MaterialPageRoute(builder: (context) => Profile(widget.user)
              //   )
              // )
            ),
            ListTile(
              title:Text('ViewProfile',style:TextStyle(color:Colors.black,fontSize:20 )),
              leading:Icon(Icons.person),
              onTap:()=>  Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>ViewProfile(widget.user)
                )
              )
            ),



          ],
        ),
      );

    
  }
}