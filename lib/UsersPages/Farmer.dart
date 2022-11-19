import 'package:agriculture/login.dart';
import 'package:agriculture/models/Farmer_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

import '../FarmerPages/Profile.dart';


class Farmer extends StatefulWidget {
    // User? user =  FirebaseAuth.instance.currentUser;

    User user;
    Farmer(this.user);
  @override
  State<Farmer> createState() => _FarmerState();
}

class _FarmerState extends State<Farmer> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farmer"),
        
        actions: [


          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
          
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
                Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Profile(widget.user))
                );
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
