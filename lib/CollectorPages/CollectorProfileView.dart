import 'package:agriculture/CollectorPages/EditCollectorProfile.dart';
import 'package:agriculture/CollectorPages/Farmers_detail.dart';
import 'package:agriculture/FarmerPages/EditProfile.dart';
import 'package:agriculture/login.dart';
import 'package:agriculture/models/CollectorProfile.dart';
import 'package:agriculture/models/Farmer_profile.dart';
import 'package:agriculture/shared_preferences/user_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../UsersPages/Collector.dart';
import '../UsersPages/Farmer.dart';
import '../services/firestore_service.dart';

import '../FarmerPages/Profile.dart';


class CollectorViewProfile extends StatefulWidget {

  @override
  State<CollectorViewProfile> createState() => _CollectorViewProfileState();
}

class _CollectorViewProfileState extends State<CollectorViewProfile> {
//  bool profile_created =false;
//  bool _profile = false;

// get profilecreated =>profile_created;
String MyEmail = "";
var Uid="";
  @override
  void initState(){

    farmer_profile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final  Collector_id = ModalRoute.of(context)!.settings.arguments;
  

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
                MaterialPageRoute(builder: (context) =>Collector()
                )
              )
            ),

            // _profile?Text('Disabled'):ListTile(
            //   title:Text('Create Profile',style:TextStyle(color:Colors.black,fontSize:16 )),
            //   leading:Icon(Icons.person_add_alt_1_rounded,color:Colors.blue),
            //   trailing:Icon(Icons.arrow_forward),
            //   onTap:()=>  Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => Profile(widget.user)
            //     )
            //   )
            // ),
            ListTile(
              title:Text('Profile',style:TextStyle(color:Colors.black,fontSize:16 )),
              leading:Icon(Icons.person_rounded,color:Colors.blue),
              trailing:Icon(Icons.arrow_forward),
                onTap:()=>  Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>CollectorViewProfile(),
                )
              )
            ),
                        ListTile(
              title:Text('Collections',style:TextStyle(color:Colors.black,fontSize:16 )),
              leading:Icon(Icons.person_rounded,color:Colors.blue),
              trailing:Icon(Icons.arrow_forward),
                onTap:()=>  Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>Farmers_Detail(),
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
        
        title: Text("View Profile"),
        
        actions: [


          
        ],
      ),
      body: 
      
      StreamBuilder(
                  stream:FirebaseFirestore.instance.collection('Collectors_profile').where('UserId',isEqualTo:Uid).snapshots(),
                  builder:(context,AsyncSnapshot snapshot){
                    if(snapshot.hasData){
                      
                      
                      if(snapshot.data.docs.length>0){
                          return ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder:(context,index){
                            Collector_profile_model  profile = Collector_profile_model.frommJson(snapshot.data.docs[index]);
                              // print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                              // print(profile.full_name);
                              // final pref =UserPreferences().getUserProfile(profile.id);
                             
                              
                              // print(pref);
                              // if(profile.id!=null){
                                
                              //     _profile=true;
                                
                              
                              // }
                              return  Column(
                                children: [
                        //           Card(
                        //   color:Colors.teal,
                        //   margin:EdgeInsets.all(10),
                        //   child:ListTile(
                        //     contentPadding:EdgeInsets.symmetric(horizontal:10,vertical:5),
                        //     title:Text(profile.Email,style:TextStyle(fontSize:10,fontWeight:FontWeight.bold)),
                        //     subtitle:Text(profile.number_of_beehive,style:TextStyle(fontSize:8,fontWeight:FontWeight.bold),)
                        //   ),
                        // ),
                const SizedBox(height:24),
                                                      Stack(
                      
                      children: [
                        // buildImage(),
                                                ClipOval(
                          // clipper: ,
                          child:profile.imageUrl==''?  Image.asset('images/agri.jpg',                                     
                         fit:BoxFit.cover,
                        width:128,
                        height:128,
                      ):
                        Image.network(profile.imageUrl,fit:BoxFit.cover,

                        width:128,
                        height:128,
                        ) 
                          


                        ),

                        Positioned(
                          bottom:0,
                          right:4,
                          child: buildEditIcon(Colors.blue)
                          ),
                        ]
                        ),
  
                ProfileWidget(profile),
                        
                SizedBox(height:20),
                Center(child:ElevatedButton(onPressed:(){
                // Navigator.pushReplacement(context,
                // MaterialPageRoute(builder: (context) => EditCollectorProfile(profile),
                // // settings: RouteSettings(arguments:profile),

                // )
                // );
              },
              child:Text("Edit  Profile"),
               ) ,),

                                ],
                              );

                            },
                          );
                      }else{
                        return Center(
                          
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              
                                Text("Not created profile"),
                                                SizedBox(height:20),
                // ElevatedButton(onPressed:(){
                // Navigator.pushReplacement(context,
                // MaterialPageRoute(builder: (context) => Profile(widget.user))
                // );
                // },
                //                 child:Text("Create Profile"),

                //               ),
                            ],
                          ),
                        );
                      }
                    }
                    return Center(
                        child:CircularProgressIndicator(),
                    );
                  }
                ),
        
      );
              

  }
  Widget ProfileWidget(Collector_profile_model profile)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text("Full name:  "+profile.full_name,style:TextStyle(
      fontWeight:FontWeight.bold,fontSize:15
    )),
    SizedBox(height:10),
        Text("Email:  "+MyEmail,style:TextStyle(
      fontWeight:FontWeight.bold,fontSize:15
    )),
        SizedBox(height:10),
        Text("Contact number:  "+profile.phone_number,style:TextStyle(
      fontWeight:FontWeight.bold,fontSize:15
    )),

  ],);

 
 farmer_profile() async{
      User? user =await  FirebaseAuth.instance.currentUser;
       await  FirebaseFirestore.instance.collection('Collectors').doc(user!.uid).get().
            then((DocumentSnapshot documentSnapshot){
                          if(documentSnapshot.exists){
                         var myEmail=documentSnapshot.get("email");
                         var uid = documentSnapshot.id;
                         
                              setState(() {
                              MyEmail= myEmail;
                              Uid =uid;
                            });

                            print(".........................................");
                            print(MyEmail);
                            print(Uid);
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
            //  _pickImageCamera(),
          },
          child: buildCircle(
            color:color,
            all:8,
            child: Icon(
              Icons.edit,
        
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
