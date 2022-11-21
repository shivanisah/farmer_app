import 'package:agriculture/CollectorPages/Collection_details.dart';
import 'package:agriculture/CollectorPages/drawer.dart';
import 'package:agriculture/login.dart';
import 'package:agriculture/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/Farmer_profile.dart';


class Farmers_Detail extends StatefulWidget {
  const Farmers_Detail({super.key});

  @override
  State<Farmers_Detail> createState() => _Farmers_DetailState();
}

class _Farmers_DetailState extends State<Farmers_Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:SideBar(),
      appBar: AppBar(
        title: Text("Farmers Profile"),
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
                              title:Text.rich(TextSpan(text:"Name: ",
                              style:TextStyle(fontSize:16,fontWeight:FontWeight.bold),
                              children:[
                                TextSpan(text:profile.name,
                                style:TextStyle(fontSize:16)
                                )
                              ]
                              )
                              ),
                              // title:Text("Name: "+profile.name,style:TextStyle(fontSize:16,fontWeight:FontWeight.bold)),
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
                              
                              "Collection",
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
