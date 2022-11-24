import 'dart:async';

import 'package:agriculture/AdminPages/CollectorMainPage.dart';
import 'package:agriculture/CollectorPages/CollectorProfileView.dart';
import 'package:agriculture/CollectorPages/drawer.dart';
import 'package:agriculture/FarmerPages/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../AdminPages/FarmerMainPage.dart';
import '../UsersPages/Admin.dart';
import '../UsersPages/Collector.dart';
import '../UsersPages/Farmer.dart';
import '../login.dart';
import '../services/firestore_service.dart';

class CollectorProfile extends StatefulWidget {
  @override
  State<CollectorProfile> createState() => _CollectorProfileState();
}

class _CollectorProfileState extends State<CollectorProfile> {
  String MyEmail="";
  String Users="";

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController =TextEditingController();
  TextEditingController emailController =TextEditingController();

  bool loading = false;
  final formkey = GlobalKey<FormState>();
 @override
  void initState(){
    emailController.text=MyEmail;
    farmer_profile();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
            final  Collector_id = ModalRoute.of(context)!.settings.arguments as String;

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
              leading:Icon(Icons.person_add_alt_1_rounded,color:Colors.blue),
              trailing:Icon(Icons.arrow_forward),
              onTap:()=>  Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => CollectorList()
                )
              )
            ),
            ListTile(
              title:Text('Farmers List',style:TextStyle(color:Colors.black,fontSize:16 )),
              leading:Icon(Icons.person_rounded,color:Colors.blue),
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

      appBar:AppBar(
        title:Text("Your Details")
      ),
      body:
      SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Container(
              
              child:Form(
                 key: formkey,

                child:Column(
                  // mainAxisAlignment:MainAxisAlignment.start,
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: [
                    SizedBox(height:10),
                  Text(
                    Collector_id,
                    style:TextStyle(
                      fontSize:20,
                      fontWeight:FontWeight.bold,
                    )
                    ),
                    SizedBox(height:20),
                  TextFormField(
                    controller:nameController,
                    decoration:InputDecoration(
                    labelText:"Full Name",
                      icon: Icon(Icons.person)

                    ),
                    validator:(value){
                      if(value!.isEmpty){
                              return "This field is required";

                      }
                      else if(!RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                          return "Enter correct name";
                      }
                      else {
                        return null;
                      }
                    },
                  ),
              SizedBox(height:20),
                                TextFormField(
                    
                    controller:emailController,
                    decoration:InputDecoration(
                    labelText:"Email",
                      // hintText:Farmer_email,
                    // enabled:false,

                      icon: Icon(Icons.email)

                    ),
                  validator:(value){
                      if(value!.isEmpty){
                              return "This field is required";

                      }
                      else if(!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)){
                          return "Enter correct email";
                      }
                      else {
                        return null;
                      }
                    },

                  ),
              SizedBox(height:20),


                    TextFormField(
    controller: phoneController,
    keyboardType: TextInputType.number,

    decoration: InputDecoration(
        labelText:"Phone number", 
        // hintText: "Enter your phone number",
        icon: Icon(Icons.phone_android_outlined)
    ),
                        validator:(value){
                      if(value!.isEmpty){
                              return "This field is required";

                      }
                      else if(!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)){
                          return "Enter correct number";
                      }
                      else {
                        return null;
                      }
                    },

),
              SizedBox(height:20),



            loading?Center(child:CircularProgressIndicator(),):Container(
                    child: ElevatedButton(onPressed:()async{
                  if(formkey.currentState!.validate())

                      {
                        try{
                          setState(() {
                          loading:true;
                        });
                       
                        await FireStoreService().CollectorProfileCreate(nameController.text,emailController.text,phoneController.text,Collector_id);
                        setState(() {
                          loading=false;
                        });
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Profile created successfully"),backgroundColor:Colors.green));

                        Timer(Duration(seconds: 2),(){
                   Navigator.push(context,MaterialPageRoute(builder:(context)=>Admin()));

                        });
  

                        }catch(e){}
                      }


                    },
                    child:Text("Create"),),
                  ),
                ],)
              )
    
            )
          ],),
        )
      ),
    );
    
  }
 farmer_profile() async{
      User? user =await  FirebaseAuth.instance.currentUser;
       await  FirebaseFirestore.instance.collection('users').doc(user!.uid).get().
            then((DocumentSnapshot documentSnapshot){
                          if(documentSnapshot.exists){
                         var myEmail=documentSnapshot.get("email");
                         var user_as_collector=documentSnapshot.id;
                              setState(() {
                              MyEmail= myEmail;
                              Users=user_as_collector;
                            });

                            print(".........................................");
                            print(MyEmail);
                                                }
                                                }
                                           
    );

  }

   collectors_profile() async{
      User? user =await  FirebaseAuth.instance.currentUser;
       await  FirebaseFirestore.instance.collection('users').doc(user!.uid).get().
            then((DocumentSnapshot documentSnapshot){
                          if(documentSnapshot.exists){
                         var myEmail=documentSnapshot.get("email");
                         var user_as_collector=documentSnapshot.id;
                              setState(() {
                              MyEmail= myEmail;
                              Users=user_as_collector;
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
