import 'package:agriculture/AdminPages/CollectorMainPage.dart';
import 'package:agriculture/AdminPages/FarmerMainPage.dart';
import 'package:agriculture/AdminPages/FarmerProfileList.dart';
import 'package:agriculture/CollectorPages/Collection_details.dart';
import 'package:agriculture/CollectorPages/drawer.dart';
import 'package:agriculture/UsersPages/Admin.dart';
import 'package:agriculture/login.dart';
import 'package:agriculture/models/CollectorProfile.dart';
import 'package:agriculture/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/Farmer_profile.dart';


class Collector_Detail extends StatefulWidget {
  const Collector_Detail({super.key});

  @override
  State<Collector_Detail> createState() => _Collector_DetailState();
}

class _Collector_DetailState extends State<Collector_Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
                  drawer:
      Drawer(
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
              leading:Icon(Icons.person_add_alt_1_rounded,color:Colors.blue),
              trailing:Icon(Icons.arrow_forward),
              onTap:()=>  Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => CollectorList()
                )
              )
            ),
             ListTile(
              title:Text('Collectors List',style:TextStyle(color:Colors.black,fontSize:16 )),
              leading:Icon(Icons.person_add_alt_1_rounded,color:Colors.blue),
              trailing:Icon(Icons.arrow_forward),
              onTap:()=>  Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Collector_Detail()
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
              title:Text('Farmers Profile Page',style:TextStyle(color:Colors.black,fontSize:16 )),
              leading:Icon(Icons.person_rounded,color:Colors.blue),
              trailing:Icon(Icons.arrow_forward),
                onTap:()=>  Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>Farmers_profile_detail()
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
        title: Text("Collectors_Profile"),
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
                  stream:FirebaseFirestore.instance.collection('Collectors_profile').snapshots(),
                  builder:(context,AsyncSnapshot snapshot){
                    if(snapshot.hasData){
                      if(snapshot.data.docs.length>0){
                          return ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder:(context,index){
                              Collector_profile_model profile = Collector_profile_model.frommJson(snapshot.data.docs[index]);
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
                                TextSpan(text:profile.full_name,
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
                      //           Navigator.push(context,
                      // MaterialPageRoute(
                      // builder: (context) =>  CollectionDetailPage(),
                      // settings: RouteSettings(arguments:profile.userId )));

                      },
                            child: Text(
                              
                              "Add",
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
