import 'package:agriculture/FarmerPages/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../UsersPages/Farmer.dart';
import '../login.dart';
import '../services/firestore_service.dart';
import 'ViewProfile.dart';

class Profile extends StatefulWidget {
  User user ;
  Profile(this.user);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

    farmer_profile();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
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
                MaterialPageRoute(builder: (context) =>Farmer(widget.user)
                )
              )
            ),

            ListTile(
              title:Text('Create Profile',style:TextStyle(color:Colors.black,fontSize:16 )),
              leading:Icon(Icons.person_add_alt_1_rounded,color:Colors.blue),
              trailing:Icon(Icons.arrow_forward),
              onTap:()=>  Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Profile(widget.user)
                )
              )
            ),
            ListTile(
              title:Text('View Profile',style:TextStyle(color:Colors.black,fontSize:16 )),
              leading:Icon(Icons.person_rounded,color:Colors.blue),
              trailing:Icon(Icons.arrow_forward),
                onTap:()=>  Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>ViewProfile(widget.user)
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
//         leading:BackButton(onPressed:()=>Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ViewProfile(widget.user),
//                           ),
//                         )
// ,),
        title:Text("Farmer")
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

                    )
                  ),
              SizedBox(height:20),


                    TextFormField(
    controller: phoneController,
    keyboardType: TextInputType.number,

    decoration: InputDecoration(
        labelText:"Phone number", 
        // hintText: "Enter your phone number",
        icon: Icon(Icons.phone_android_outlined)
    )
),
              SizedBox(height:20),
                                TextFormField(
                    keyboardType: TextInputType.number,

                    controller:additionalNumberController,
                    decoration:InputDecoration(
                    labelText:"Additionl number",
                      icon: Icon(Icons.phone)

                    )
                  ),
              SizedBox(height:20),


  TextFormField(
    controller: permanentAddController,
    

    decoration: InputDecoration(
        labelText:"Permanent address", 
        // hintText: "Enter your permanent address",
        icon: Icon(Icons.home)
    )
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

                    )

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

                    )
                  ),
              SizedBox(height:20),
                                TextFormField(
                     keyboardType:TextInputType.multiline,
                     maxLines:5,           
                    controller:possibleMigController,
                    decoration:InputDecoration(
                    labelText:"Possible migration",
                      icon: Icon(Icons.card_travel_outlined)

                    )
                  ),
              SizedBox(height:20),
                  TextFormField(
                  keyboardType: TextInputType.number,

                    controller:noBeehiveController,
                    decoration:InputDecoration(
                    labelText:"Beehive number",
                      icon: Icon(Icons.person)

                    )
                  ),
              SizedBox(height:20),


         

            loading?Center(child:CircularProgressIndicator(),):Container(
                    child: ElevatedButton(onPressed:()async{
                      if(nameController.text==""|| phoneController.text=="")

                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("All fields are required"),backgroundColor:Colors.red));
                      }
                      else 
                      {
                        setState(() {
                          loading:true;
                        });
                       
                        await FireStoreService().createProfile(nameController.text,emailController.text,phoneController.text,additionalNumberController.text,permanentAddController.text,
                        temporaryAddController.text,latLong_locationController.text,capacityController.text,possibleMigController.text,noBeehiveController.text,
                        widget.user.uid);
                        setState(() {
                          loading=false;
                        });
                        Navigator.push(context,MaterialPageRoute(builder:(context)=>ViewProfile(widget.user)));
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
