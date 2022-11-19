import 'package:agriculture/CollectorPages/Collection_details.dart';
import 'package:agriculture/login.dart';
import 'package:agriculture/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/Farmer_profile.dart';


class Collector extends StatefulWidget {
  const Collector({super.key});

  @override
  State<Collector> createState() => _CollectorState();
}

class _CollectorState extends State<Collector> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Collector"),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(
              Icons.logout,
            ),
          )
        ],
      ),
                body:    Container(

                child: StreamBuilder(
                  stream:FirebaseFirestore.instance.collection('Farmers_profile').snapshots(),
                  builder:(context,AsyncSnapshot snapshot){
                    if(snapshot.hasData){
                      if(snapshot.data.docs.length>0){
                          return ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder:(context,index){
                              profileModel profile = profileModel.fromJson(snapshot.data.docs[index]);
                              return  Column(
                                children: [
                          Card(
                          shadowColor:Colors.black.withAlpha(100),
                          elevation: 30,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          color:Colors.blue[100],
                          margin:EdgeInsets.all(10),
                          child:Container(
                           decoration: BoxDecoration(),
                            child: ListTile(
                              contentPadding:EdgeInsets.symmetric(horizontal:10,vertical:5),
                              title:Text("Full name: "+profile.name,style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
                              subtitle:Text("Phone number: "+profile.phone_number.toString(),style:TextStyle(fontSize:10,fontWeight:FontWeight.bold),),
                              leading: Icon(Icons.person),
                              dense:true,
                              // tileColor: Colors.blue[100],
                              trailing:TextButton(
                              onPressed: () {
                                Navigator.push(context,
                      MaterialPageRoute(
                      builder: (context) =>  CollectionDetailPage(),
                      settings: RouteSettings(arguments:profile.userId )));

                      },
                            child: Text(
                              
                              "Add/Edit",
                              style: TextStyle(
                                fontSize: 20,
                                color:Colors.teal
                              ),
                            ),

                              )
                              
                            ),
                          ),
                        ),


                                ],
                              );

                            },
                          );
                      }else{
                        return Center(
                          child:Text("No profile created")
                        );
                      }
                    }
                    return Center(
                        child:CircularProgressIndicator(),
                    );
                  }
                ),
              ),

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
  
  collectionDetailPage() {}
}
