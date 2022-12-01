import 'dart:async';

import 'package:agriculture/FarmerPages/drawer.dart';
import 'package:agriculture/models/Farmer_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../UsersPages/Farmer.dart';
import '../login.dart';
import '../services/firestore_service.dart';
import 'ViewProfile.dart';

class EditFarmerProfile extends StatefulWidget {
  profileModel profile;
  EditFarmerProfile(this.profile);
  
  // User get user =>FirebaseAuth.instance.f ;
  @override
  State<EditFarmerProfile> createState() => _EditFarmerProfileState();
}

class _EditFarmerProfileState extends State<EditFarmerProfile> {
      // User? user = FirebaseAuth.instance.currentUser;
  String MyEmail="";

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController =TextEditingController();
  TextEditingController permanentAddController =TextEditingController();
  TextEditingController temporaryAddController =TextEditingController();
  TextEditingController possibleMigController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController additionalNumberController =TextEditingController();
  TextEditingController noBeehiveController =TextEditingController();
  TextEditingController capacityController =TextEditingController();
  TextEditingController latLong_locationController =TextEditingController();
  bool loading = false;
  final formkey = GlobalKey<FormState>();
 @override
  void initState(){
    nameController.text=widget.profile.name;
    phoneController.text=widget.profile.phone_number;
    emailController.text=widget.profile.Email;
    permanentAddController.text=widget.profile.permanent_address;
    temporaryAddController.text=widget.profile.temporary_address;
    possibleMigController.text=widget.profile.migration_location;
    additionalNumberController.text=widget.profile.additional_number;
    noBeehiveController.text=widget.profile.number_of_beehive;
    capacityController.text=widget.profile.capacity_of_production;  
    latLong_locationController.text=widget.profile.lat_long_location;




    farmer_profile();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
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
                MaterialPageRoute(builder: (context) =>Farmer()
                )
              )
            ),

            // ListTile(
            //   title:Text('Profile',style:TextStyle(color:Colors.black,fontSize:16 )),
            //   leading:Icon(Icons.person_add_alt_1_rounded,color:Colors.blue),
            //   trailing:Icon(Icons.arrow_forward),
            //   onTap:()=>  Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => Profile(widget.user)
            //     )
            //   )
            // ),
            ListTile(
              title:Text('View Profile',style:TextStyle(color:Colors.black,fontSize:16 )),
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
                        buildImage(),
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
              SizedBox(height:20),
                                TextFormField(
                    keyboardType: TextInputType.number,

                    controller:additionalNumberController,
                    decoration:InputDecoration(
                    labelText:"Additionl number",
                      icon: Icon(Icons.phone)

                    ),
               validator:(value){
                      if(value!.isEmpty){
                              return null;

                      }
                     if(!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)){
                          return "Enter correct number";
                      }

                      else{
                        return null;
                      }
                    },

                  ),
              SizedBox(height:20),


  TextFormField(
    controller: permanentAddController,
    

    decoration: InputDecoration(
        labelText:"Permanent address", 
        // hintText: "Enter your permanent address",
        icon: Icon(Icons.home)
    ),
                        validator:(value){
                      if(value!.isEmpty){
                              return "This field is required";

                      }
                      else{
                        return null;
                      }
                    },

),
                  SizedBox(
                    height:20,
                  ),

                  TextFormField(
                    controller:temporaryAddController,
                    decoration:InputDecoration(
                      // border:OutlineInputBorder(),
                    labelText:"Temporary address",
                      icon: Icon(Icons.location_city),

                    ),
                                        validator:(value){
                      if(value!.isEmpty){
                              return "This field is required";

                      }
                      else{
                        return null;
                      }
                    },


                  ),
                                   SizedBox(
                    height:20,
                  ),

                  TextFormField(
                    controller:latLong_locationController,
                    decoration:InputDecoration(
                    labelText:"Location latitude and longitude",
                    icon: Icon(Icons.directions)


                    )

                  ),


             SizedBox(
                    height:20,
                  ),

                           TextFormField(

                    controller:capacityController,
                    decoration:InputDecoration(
                    labelText:"Quantity of production",
                      icon: Icon(Icons.line_weight)

                    ),
                    validator:(value){
                      if(value!.isEmpty){
                              return "This field is required";

                      }
                      else{
                        return null;
                      }
                    },

                  ),
              SizedBox(height:20),
                                TextFormField(
                     keyboardType:TextInputType.multiline,
                     maxLines:5,           
                    controller:possibleMigController,
                    decoration:InputDecoration(
                    labelText:"Possible migration",
                      icon: Icon(Icons.card_travel_outlined)

                    ),
                  validator:(value){
                      if(value!.isEmpty){
                              return "This field is required";

                      }
                      else{
                        return null;
                      }
                    },

                  ),
              SizedBox(height:20),
                  TextFormField(
                  keyboardType: TextInputType.number,

                    controller:noBeehiveController,
                    decoration:InputDecoration(
                    labelText:"Beehive number",
                      icon: Icon(Icons.person),

                    ),

                    validator:(value){
                      if(value!.isEmpty){
                              return "This field is required";

                      }
                      else{
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
                          loading=true;
                        });
                       
                        await FireStoreService().updateFarmerProfile(nameController.text,emailController.text,phoneController.text,additionalNumberController.text,permanentAddController.text,
                        temporaryAddController.text,latLong_locationController.text,capacityController.text,possibleMigController.text,noBeehiveController.text,
                        widget.profile.id);
                        setState(() {
                          loading=false;
                        });
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Profile updated successfully"),backgroundColor:Colors.green));

                        Timer(Duration(seconds: 2),(){
                   Navigator.push(context,MaterialPageRoute(builder:(context)=>ViewProfile()));
                        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>");

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
Widget buildImage(){
  final image = AssetImage('images/agri.jpg');
  return ClipOval(
    child: Material(
      color:Colors.transparent,
      child: Ink.image(
        image:image,
        fit:BoxFit.cover,
        width:128,
        height:128,
        child:InkWell(onTap:()=>{})
      ),
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
