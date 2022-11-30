import 'dart:async';
import 'dart:io';

import 'package:agriculture/AdminPages/CollectorMainPage.dart';
import 'package:agriculture/CollectorPages/CollectorProfileView.dart';
import 'package:agriculture/CollectorPages/drawer.dart';
import 'package:agriculture/FarmerPages/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import '../AdminPages/FarmerMainPage.dart';
import '../UsersPages/Admin.dart';
import '../UsersPages/Collector.dart';
import '../UsersPages/Farmer.dart';
import '../Widgets/designcolor.dart';
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
  var url;
//  late File image = File('your initial file');
  var _image;
  final picker = ImagePicker();
Future _pickImageCamera() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _image = pickedImageFile;
    });
  }

  Future uploadImage(var _image) async{
    Reference reference = FirebaseStorage.instance.ref().child('images').child(emailController.text+'.jpg');
    await reference.putFile(_image);
    url = await reference.getDownloadURL();
    return url;
  }

 @override
  void initState(){
    emailController.text=MyEmail;
    farmer_profile();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
            final color = Colors.blue;


            final  Collector_id = ModalRoute.of(context)!.settings.arguments as String;
            // print("********************************************");
            // print(Collector_id)

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

                         Text( Collector_id,
                         style: TextStyle(color: Palette.lightPurple,fontSize: 
                                    19,fontWeight: FontWeight.bold),),
                                    SizedBox(height: 17,),

                                      Stack(
                      
                      children: [
                        // buildImage(),
                        ClipOval(
                          // clipper: ,
                          child:_image!=null?Image.file(_image,fit:BoxFit.cover,
                        width:128,
                        height:128,
                        ) :
                          

                        Image.asset('images/agri.jpg',                                     
                         fit:BoxFit.cover,
                        width:128,
                        height:128,
                      ),

                        ),
                        Positioned(
                          bottom:0,
                          right:4,
                          child: buildEditIcon(color)
                          ),
                        ]
                        ),
    

            Container(
              
              child:Form(
                 key: formkey,

                child:Column(
                  // mainAxisAlignment:MainAxisAlignment.start,
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: [
                   SizedBox(height:10),

                  TextFormField(
                    controller:nameController,
                    decoration:InputDecoration(
                    labelText:"Full Name",
                      icon: Icon(Icons.person,color:Colors.blue)

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
                    // enabled:false,

                      icon: Icon(Icons.email,color: Colors.blue,)

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
        icon: Icon(Icons.phone_android_outlined,color: Colors.blue)
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
                                         final imgUrl = await uploadImage(_image);

                        await FireStoreService().CollectorProfileCreate(nameController.text,emailController.text,phoneController.text,Collector_id,imgUrl);

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


Widget buildEditIcon(Color color)=>
      buildCircle(
        color:Colors.white,
        all:3,
        child: InkWell(
          onTap:()=>{
             _pickImageCamera(),
          },
          child: buildCircle(
            color:color,
            all:8,
            child: Icon(
              Icons.add_a_photo,
        
              size:20,
              color:Colors.white,
            
            ),
                      
        
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
