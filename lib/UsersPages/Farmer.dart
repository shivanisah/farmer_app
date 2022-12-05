import 'package:agriculture/login.dart';
import 'package:agriculture/models/Farmer_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../FarmerPages/ViewProfile.dart';
import '../services/firestore_service.dart';

import '../FarmerPages/Profile.dart';


class Farmer extends StatefulWidget {
    // User? user =  FirebaseAuth.instance.currentUser;

    // User user;
    // Farmer(this.user);
  @override
  State<Farmer> createState() => _FarmerState();
}

class _FarmerState extends State<Farmer> {
  String MyEmail="";
    @override
  void initState(){

    farmer_profile();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
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
                MaterialPageRoute(builder: (context) =>Farmer()
                )
              )
            ),

            // ListTile(
            //   title:Text('Profile',style:TextStyle(color:Colors.black,fontSize:16 )),
            //   leading:Icon(Icons.person_add_alt_1_rounded,color:Colors.blue),
            //   trailing:Icon(Icons.arrow_forward),
            //   onTap:()=>  Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => Profile()
            //     )
            //   )
            // ),
            ListTile(
              title:Text('Profile',style:TextStyle(color:Colors.black,fontSize:16 )),
              leading:Icon(Icons.person_rounded,color:Colors.blue),
              trailing:Icon(Icons.arrow_forward),
                onTap:()=>  Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>ViewProfile()
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
        
        title: Text("Farmer"),
        
        actions: [


          IconButton(
            onPressed: () {
              // logout(context);
              Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>ViewProfile()
                )
              );
            },
            icon: Icon(
              Icons.person,
            ),
          ),
          
        ],
      ),
        
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
 farmer_profile() async{
      User? user =await  FirebaseAuth.instance.currentUser;
       await  FirebaseFirestore.instance.collection('Farmers').doc(user!.uid).get().
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
