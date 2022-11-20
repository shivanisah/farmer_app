import 'package:agriculture/login.dart';
import 'package:agriculture/models/Farmer_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../UsersPages/Farmer.dart';
import '../services/firestore_service.dart';

import '../FarmerPages/Profile.dart';


class ViewProfile extends StatefulWidget {
    // User? user =  FirebaseAuth.instance.currentUser;

    User user;
    
    ViewProfile(this.user);
  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
 bool profile_created =false;

get profilecreated =>profile_created;
String MyEmail = "";
  @override
  void initState(){

    farmer_profile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

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

      appBar: AppBar(
        
        title: Text("View Profile"),
        
        actions: [


          
        ],
      ),
      body: StreamBuilder(
                  stream:FirebaseFirestore.instance.collection('Farmers_profile').where('userId',isEqualTo:widget.user.uid).snapshots(),
                  builder:(context,AsyncSnapshot snapshot){
                    if(snapshot.hasData){
                      
                      
                      if(snapshot.data.docs.length>0){
                          return ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder:(context,index){
                              profileModel profile = profileModel.fromJson(snapshot.data.docs[index]);
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
                ProfileWidget(profile),
                        
                SizedBox(height:20),
                Center(child:ElevatedButton(onPressed:(){
                // Navigator.pushReplacement(context,
                // MaterialPageRoute(builder: (context) => Profile(widget.user)
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
                ElevatedButton(onPressed:(){
                Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Profile(widget.user))
                );
                },
                                child:Text("Create Profile"),

                              ),
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
  Widget ProfileWidget(profileModel profile)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text("Full name:  "+profile.name,style:TextStyle(
      fontWeight:FontWeight.bold,fontSize:15
    )),
    SizedBox(height:10),
        Text("Email:  "+profile.Email,style:TextStyle(
      fontWeight:FontWeight.bold,fontSize:15
    )),
        SizedBox(height:10),
        Text("Contact number:  "+profile.phone_number,style:TextStyle(
      fontWeight:FontWeight.bold,fontSize:15
    )),
        SizedBox(height:10),
        Text("Permanent address:  "+profile.permanent_address,style:TextStyle(
      fontWeight:FontWeight.bold,fontSize:15
    )),
        SizedBox(height:10),
        Text("Temporary address:  "+profile.temporary_address,style:TextStyle(
      fontWeight:FontWeight.bold,fontSize:15
    )),
        SizedBox(height:10),
        Text("Quantity of production:  "+profile.capacity_of_production,style:TextStyle(
      fontWeight:FontWeight.bold,fontSize:15
    )),
        SizedBox(height:10),
        Text("Possible migration location:  "+profile.migration_location,style:TextStyle(
      fontWeight:FontWeight.bold,fontSize:15
    )),

  ],);

 
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
