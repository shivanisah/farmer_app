import 'dart:async';

import 'package:agriculture/CollectorPages/drawer.dart';
import 'package:agriculture/FarmerPages/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../UsersPages/Collector.dart';
import '../UsersPages/Farmer.dart';
import '../login.dart';
import '../services/firestore_service.dart';

class CollectorProfile extends StatefulWidget {
  // User currentuser ;
  // CollectorProfile(this.currentuser);
  @override
  State<CollectorProfile> createState() => _CollectorProfileState();
}

class _CollectorProfileState extends State<CollectorProfile> {
  String MyEmail="";

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController =TextEditingController();
  TextEditingController emailController =TextEditingController();

  bool loading = false;
  final formkey = GlobalKey<FormState>();
 @override
  void initState(){

    farmer_profile();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:SideBar(),

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
                    "Your Details",
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
                      // if(nameController.text==""|| phoneController.text==""||emailController.text=="")

                      // {
                      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("All fields are required"),backgroundColor:Colors.red));
                      // }    
                      if(formkey.currentState!.validate())

                      {
                      try{
                          setState(() {
                          loading:true;
                        });
                       
                        await FireStoreService().CollectorProfileCreate(nameController.text,emailController.text,phoneController.text);
                        setState(() {
                          loading=false;
                        });
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Profile created successfully"),backgroundColor:Colors.green));

                        Timer(Duration(seconds: 2),(){
                          Navigator.push(context,MaterialPageRoute(builder:(context)=>Collector()));

                        });


                      }catch(e){};

                      }



                    },
                    child:Text("Save"),),
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
