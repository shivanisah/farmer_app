import 'dart:async';

import 'package:agriculture/CollectorPages/CollectorProfileView.dart';
import 'package:agriculture/CollectorPages/Farmers_detail.dart';
import 'package:agriculture/FarmerPages/drawer.dart';
import 'package:agriculture/UsersPages/Collector.dart';
import 'package:agriculture/models/CollectorProfile.dart';
import 'package:agriculture/models/Farmer_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../AdminPages/CollectorMainPage.dart';
import '../AdminPages/FarmerMainPage.dart';
import '../UsersPages/Admin.dart';
import '../UsersPages/Farmer.dart';
import '../login.dart';
import '../services/firestore_service.dart';

class EditCollectorProfile extends StatefulWidget {
  Collector_profile_model  profile;
  EditCollectorProfile(this.profile);
  @override
  State<EditCollectorProfile> createState() => _EditCollectorProfileState();
}

class _EditCollectorProfileState extends State<EditCollectorProfile> {
  // ignore: non_constant_identifier_names
 


  String MyEmail="";

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  bool loading = false;
  final formkey = GlobalKey<FormState>();
 @override
  void initState(){
    nameController.text=widget.profile.full_name;
    
    phoneController.text=widget.profile.phone_number;
    emailController.text=widget.profile.email;
    farmer_profile();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // final  Profile = ModalRoute.of(context)!.settings.arguments ;
    // print("Profile........................................List");
    // print(widget.Profile.full_name);
    // var data = Collector_profile_model.frommJson(Profile)

    final color = Colors.blue;
    // final profil = ViewProfile(widget.user);
    return Scaffold(
      drawer:Drawer(
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
        title:Text("Edit Profile")
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

                    Stack(
                      
                      children: [
                              
                        ClipOval(
                          // clipper: ,
                          child:widget.profile.imageUrl==''?  Image.asset('images/agri.jpg',                                     
                         fit:BoxFit.cover,
                        width:128,
                        height:128,
                      ):
                        Image.network(widget.profile.imageUrl,fit:BoxFit.cover,
                        width:128,
                        height:128,
                        ) 
                          


                        ),
                              
                        Positioned(
                          bottom:0,
                          right:4,
                          child: buildEditIcon(color)
                          ),
                        ]
                        ),

                    SizedBox(height:10),
                  // Text(
                  //   "Your Details",
                  //   style:TextStyle(
                  //     fontSize:20,
                  //     fontWeight:FontWeight.bold,
                  //   )
                  //   ),
                    // SizedBox(height:20),
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


                      else{
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
                              return null;

                      }
                       if(!RegExp(
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

                      else{
                        return null;
                      }
                    },


),


         

            loading?CircularProgressIndicator():Container(
                    child: ElevatedButton(onPressed:()async{
                  if(formkey.currentState!.validate())

                      {
                        try{
                          setState(() {
                          loading=true;
                        });
                       
                        await FireStoreService().updateCollectorProfile(nameController.text,emailController.text,phoneController.text,
                           widget.profile.id);
                        setState(() {
                          loading=false;
                        });
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Profile updated successfully "),backgroundColor:Colors.green));

                        Timer(Duration(seconds: 2),(){
                   Navigator.push(context,MaterialPageRoute(builder:(context)=>CollectorList()));

                        });
  

                        }catch(e){}
                      }


                    },
                    child:Text("Update Profile"),),
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

Widget buildEditIcon(Color color)=>
      buildCircle(
        color:Colors.white,
        all:3,
        child: buildCircle(
          color:color,
          all:8,
          child: Icon(
            Icons.add_a_photo,
            size:20,
            color:Colors.white,
          
          ),
        ),
      );


 Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
 })=>ClipOval(
   child: Container(
    color:color,
    child:child,
    padding:EdgeInsets.all(all),
    
    ),
 );     


}
