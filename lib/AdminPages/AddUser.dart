import 'dart:async';

import 'package:agriculture/CollectorPages/Farmers_detail.dart';
import 'package:agriculture/CollectorPages/drawer.dart';
import 'package:agriculture/FarmerPages/Profile.dart';
import 'package:agriculture/models/Farmer_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../UsersPages/Admin.dart';
import '../UsersPages/Collector.dart';
import '../Widgets/designcolor.dart';
import '../login.dart';
import '../services/firestore_service.dart';
import 'CollectorMainPage.dart';
import 'FarmerMainPage.dart';

class Adduser extends StatefulWidget {
  
   Adduser({Key? key, }) : super(key: key);

  @override
  State<Adduser> createState() => _AdduserState();
}

class _AdduserState extends State<Adduser> {
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmpassController =new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;
  String MyEmail="";
  var options = [
    'collector',
    'Farmer',
  ];
  var _currentItemSelected = "collector";
  var role = "collector";
  bool loading =false;

  @override
   void initState(){
    farmer_profile();
    super.initState();
   }

  @override 
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    confirmpassController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      drawer:      Drawer(
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


    appBar:AppBar(title:Text("Admin")),  
  
    body:
          SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
         SizedBox(height:80),
                            Text("Add User",
                       style: TextStyle(color:Colors.blueAccent,fontSize: 
                                    25,fontWeight: FontWeight.bold),),
                                    SizedBox(height: 24,),

            Container(
              
              child:Form(
              key: _formkey,

                child:Column(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: [

                    
                                                       SizedBox(height: 10,),

                                        Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    padding: EdgeInsets.only(left: 4,top:1,bottom: 4,right: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(29),
                                      boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0,0),
                                                      blurRadius: 5,
                                                      color:Colors.black.withOpacity(0.2),
                                      
                                                    )
                                                  ]
                                    ),
                                    child:TextFormField(
                                      keyboardType:TextInputType.emailAddress,
                                      controller:emailController,

                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.76),
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          prefixIcon:Icon(Icons.email),

                                          // floatingLabelAlignment: FloatingLabelAlignment.start,
                                          // // floatingLabelBehavior: FloatingLabelBehavior.always,
                                          // labelStyle: TextStyle(color: Palette.lightPurple,fontSize: 19),
                                          hintText: 'Email',
                                          
                                          hintStyle: TextStyle(
                                            color: Colors.black.withOpacity(0.6)
                                          ),
                                         
                                          
                                          enabled: true,
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0, bottom: 8.0, top: 8.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                        ),
                            //                                         validator: (value) {
                            //   if (value!.length == 0) {
                            //     return "Email cannot be empty";
                            //   }
                            //   if (!RegExp(
                            //           "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            //       .hasMatch(value)) {
                            //     return ("Please enter a valid email");
                            //   } else {
                            //     return null;
                            //   }
                            // },

                                    ),
                                     
                                    
                                    ),SizedBox(height: 22,),

                                                            Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    padding: EdgeInsets.only(left: 4,top:1,bottom: 4,right: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(29),
                                      boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0,0),
                                                      blurRadius: 5,
                                                      color:Colors.black.withOpacity(0.2),
                                      
                                                    )
                                                  ]
                                    ),
                                    child:TextFormField(
                                     controller:passwordController,
                                      obscureText: _isObscure,


                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.76),
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        
                                        decoration: InputDecoration(
                                      prefixIcon:Icon(Icons.password),

                                   suffixIcon: IconButton(
                                  icon: Icon(_isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  }),

                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'Password',
                                          
                                          hintStyle: TextStyle(
                                            color: Colors.black.withOpacity(0.6)
                                          ),
                                         
                                          
                                          enabled: true,
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0, bottom: 8.0, top: 8.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                        ),
                          // validator: (value) {
                          //     RegExp regex = new RegExp(r'^.{6,}$');
                          //     if (value!.isEmpty) {
                            

                          //       return "Password cannot be empty";
                          //     }
                          //     if (!regex.hasMatch(value)) {
                          //       return ("please enter valid password min. 6 character");
                          //     } else {
                          //       return null;
                          //     }
                          //   },

                                    ),
                                     
                                    
                                    ),SizedBox(height: 22,),
                                                            Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    padding: EdgeInsets.only(left: 4,top:1,bottom: 4,right: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(29),
                                      boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0,0),
                                                      blurRadius: 5,
                                                      color:Colors.black.withOpacity(0.2),
                                      
                                                    )
                                                  ]
                                    ),
                                    child:TextFormField(
                                      obscureText: _isObscure2,
                                      controller:confirmpassController,

                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.76),
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        
                                        decoration: InputDecoration(
                                        prefixIcon:Icon(Icons.password),

                              suffixIcon: IconButton(
                                  icon: Icon(_isObscure2
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure2 = !_isObscure2;
                                    });
                                  }),

                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText:"Confirm Password",
                                          

                                          hintStyle: TextStyle(
                                            color: Colors.black.withOpacity(0.6),
                                          ),
                                         
                                          
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0, bottom: 8.0, top: 8.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                        ),
                            //   validator: (value) {
                            //   if (confirmpassController.text !=
                            //       passwordController.text) {
                            //     return "Password did not match";
                            //   } else {
                            //     return null;
                            //   }
                            // },
  
                                    ),
                                     
                                    
                                    ),SizedBox(height: 22,),

                                                            Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    padding: EdgeInsets.only(left: 4,top:1,bottom: 4,right: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(29),
                                      boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0,0),
                                                      blurRadius: 5,
                                                      color:Colors.black.withOpacity(0.2),
                                      
                                                    )
                                                  ]
                                    ),
                          child:DropdownButtonFormField2<String>(
                                
                                      
                                      decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          
                                        ),
                                      scrollbarAlwaysShow: true,
                                      buttonHeight: 22,
                                      itemSplashColor:Palette.lightPurple,
                                      dropdownPadding: EdgeInsets.all(15),
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius:BorderRadius.circular(17),
                                        ),

                                      isExpanded: true,
                                      // iconEnabledColor: Colors.white,
                                      focusColor: Colors.white,
                                      items: options.map((String dropDownItem) {
                                        return DropdownMenuItem<String>(
                                          
                                          value: dropDownItem,
                                          child: Text(
                                            dropDownItem,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValueSelected) {
                                        
                                    setState(() {
                                    _currentItemSelected = newValueSelected!;
                                    role = newValueSelected;
                                    });
                                          },
                                      value: _currentItemSelected,
                                    ),
 
                                    
                                    ),SizedBox(height: 22,),


        loading?CircularProgressIndicator():Container(
                    

                    child: MaterialButton(
                       minWidth: size.width*0.45,
                        height: 47,
                       color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                     elevation: 18.0,
                      onPressed:()
                      {

                        signUp(emailController.text,
                        passwordController.text, role);

                       

                      },
                    

                  
                    child:Text("Add",style: new TextStyle(fontSize: 20.0, color: Colors.white)),
                    
                    ),
                  ),
                ],)
              )
    
            )
          ],),
        )
      ),

    );
    
  }
 void signUp(String email, String password, String role ) async {
    // if (_formkey.currentState!.validate())
                          if(emailController.text==""|| passwordController.text==""||confirmpassController.text==""
                      
                      ){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("All fields are required"),backgroundColor:Colors.red));
                      }
else
     {
        setState(() {
                          loading=true;
                        });

          await _auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {

               User user = _auth.currentUser!;
               if(role=='collector'){
                 CollectionReference ref = FirebaseFirestore.instance.collection('Collectors');
           ref.doc(user.uid).set({'email': emailController.text, 'role': role,'UserId':user.uid,});
                       setState(() {
                          loading=false;
                        });

                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("User Added Successfully"),backgroundColor:Colors.green));

                        Timer(Duration(seconds: 2),(){
           Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => CollectorList()));


                        });
  

               }
               else
              {
                 CollectionReference ref = FirebaseFirestore.instance.collection('Farmers');
           ref.doc(user.uid).set({'email': emailController.text, 'role': role,'UserId':user.uid});
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("User Added Successfully"),backgroundColor:Colors.green));

          Timer(Duration(seconds: 2),(){
           Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => FarmerList()));


                        });
  
  
              }

               }
           
            // postDetailsToFirestore(email, role,UserId)
            )
          .catchError((e) {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(e.message.toString()),backgroundColor:Colors.red));
});


    }
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