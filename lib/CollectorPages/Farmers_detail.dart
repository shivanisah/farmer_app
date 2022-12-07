
import 'package:agriculture/AdminPages/FarmerMainPage.dart';
import 'package:agriculture/CollectorPages/EditCollectorProfile.dart';
import 'package:agriculture/CollectorPages/Profile.dart';
import 'package:agriculture/CollectorPages/drawer.dart';
import 'package:agriculture/FarmerPages/Profile.dart';
import 'package:agriculture/UsersPages/Admin.dart';
import 'package:agriculture/login.dart';
import 'package:agriculture/models/CollectorProfile.dart';
import 'package:agriculture/models/collection_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../CollectorPages/Collection_details.dart';
import '../shared_preferences/user_preferences.dart';


class Farmers_Detail extends StatefulWidget {
  // const Farmers_Detail({super.key});

  @override
  State<Farmers_Detail> createState() => _Farmers_DetailState();
}

class _Farmers_DetailState extends State<Farmers_Detail> {
  // var collectorId;
  // @override
  //  void initState(){
    
  //     setState(() {
  //   });
    
  //   super.initState();
    
    
  //  }
  @override
  Widget build(BuildContext context) {
    var _profile=false;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
                  drawer:SideBar(),

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
      body:
      Column(
        children: [
              SizedBox(height:24),
                              Text("Farmers Profile Details",
              style: TextStyle(color:Colors.blueAccent,fontSize: 
                                      19,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 13,),
          Container(
            padding:EdgeInsets.only(top: 20,right:10),
            child:
             StreamBuilder(
                     stream:FirebaseFirestore.instance.collection('Farmers_profile').snapshots(),

                     builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot2)
                     {
                       if(snapshot2.hasData){

                       return ListView.builder(
                         shrinkWrap: true,
                         itemCount: snapshot2.data!.docs.length,
                         itemBuilder: (context,index2){
                         DocumentSnapshot myprofile  = snapshot2.data!.docs[index2];
                         
                             return  StreamBuilder(
            stream:FirebaseFirestore.instance.collection('Collection Details').where('userId',isEqualTo: myprofile['userId']) .snapshots(),

            builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
            {
             if(snapshot.hasData){
               if(snapshot.data!.docs.length>0){
             return ListView.builder(
               shrinkWrap: true,
               itemCount: snapshot.data!.docs.length,
               itemBuilder: (context,index){
               DocumentSnapshot collectionId = snapshot.data!.docs[index];
               CollectionDetails models = CollectionDetails.fromJson(collectionId);
                
                
               var obj='';
  
                 return  
                  GestureDetector(
                                 
                                   onTap:()
                                   {
                                   
                                  //  await Navigator.push(context,
                                  //  MaterialPageRoute(
                                  //  builder: (context) =>EditCollectorProfile(models),
                                  // //  settings: RouteSettings(arguments:collectorId .id ),
                                  //  // settings: RouteSettings(arguments:collectorId[index] ),


                                  //  )
                                  //  );


                                   },
                                   child: Container(
                                     margin: EdgeInsets.only(bottom: 15),
                                     height: 72,
                                   
                                     decoration: BoxDecoration(
                                       
                                       borderRadius: BorderRadius.circular(10),
                                       color: Colors.white,
                                            boxShadow: [
                                                       BoxShadow(
                                                         offset: Offset(0,7),
                                                         blurRadius: 10,
                                                         color:Colors.black.withOpacity(0.3),
                                         
                                                       )
                                                     ]

                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.all(10.0),
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         children: [
                                           Container(
                                             width: 60,
                                             
                                             
                                             decoration: BoxDecoration(
                                               // color: Colors.red,
                                               borderRadius: BorderRadius.circular(10),
                                               image: DecorationImage(
                                                 fit: BoxFit.cover,
                                                 image: AssetImage('images/agri.jpg'),)
                                             ),
                                           ),
                                           SizedBox(width:15),
                                           
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                             
                                             children: [
                                               Padding(
                                                 padding: const EdgeInsets.only(left: 12),
                                                 child: Column(
                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                   crossAxisAlignment: CrossAxisAlignment.center,
                                                   children: [
                                                       Text(myprofile.get('name'),
                                                         style: TextStyle(
                                                           fontWeight: FontWeight.bold,
                                                           fontSize: 12,
                                                           color:   Colors.black.withOpacity(0.8)
                                                         ),
                                                       ),
                                                       SizedBox(height:4),
                                                       Text(myprofile.get('permanent_address'),
                                                         style: TextStyle(
                                                           fontWeight: FontWeight.w500,
                                                           fontSize: 13,
                                                           color: Colors.black.withOpacity(0.8),
                                                         ),
                                                       ),
                                            SizedBox(height:4),

                                                    Text(myprofile.get('phone_number'),
                                                         style: TextStyle(
                                                           fontWeight: FontWeight.w500,
                                                           fontSize: 13,
                                                           color: Colors.black.withOpacity(0.8),
                                                         ),
                                                       ),

                                                   
                                                   ],
                                                 ),
                                               ),
                                                                             SizedBox(width: size.width*0.13,),
                                           Column(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             crossAxisAlignment: CrossAxisAlignment.end,
                                             children: [             
                                                 Text('Collected',
                                                   style: TextStyle(
                                                     fontWeight: FontWeight.w500,
                                                     fontSize: 13,
                                                     color: Colors.blue,
                                                   ),
                                                 ),

                                             
                                             ],
                                           )

                                             ],
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),
                                 );
                 }
                );

               }
   
             }else{
               return Text("");
             }

               return GestureDetector(
                                 
                                   onTap:()async{
                                   
                                   await Navigator.push(context,
                                   MaterialPageRoute(
                                   builder: (context) => CollectionDetailPage(),
                                   settings: RouteSettings(arguments:myprofile.get('userId') ),
                                   // settings: RouteSettings(arguments:collectorId[index] ),


                                   )
                                   );


                                   },
                                   child: Container(
                                     margin: EdgeInsets.only(bottom: 15),
                                     height: 72,
                                   
                                     decoration: BoxDecoration(
                                       
                                       borderRadius: BorderRadius.circular(10),
                                       color: Colors.white,
                                            boxShadow: [
                                                       BoxShadow(
                                                         offset: Offset(0,7),
                                                         blurRadius: 10,
                                                         color:Colors.black.withOpacity(0.3),
                                         
                                                       )
                                                     ]

                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.all(10.0),
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         children: [
                                           Container(
                                             width: 60,
                                             
                                             
                                             decoration: BoxDecoration(
                                               // color: Colors.red,
                                               borderRadius: BorderRadius.circular(10),
                                               image: DecorationImage(
                                                 fit: BoxFit.cover,
                                                 image: AssetImage('images/agri.jpg'),)
                                             ),
                                           ),
                                           SizedBox(width:15),
                                           
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                             
                                             children: [
                                               Padding(
                                                 padding: const EdgeInsets.only(left: 12),
                                                 child: Column(
                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                   crossAxisAlignment: CrossAxisAlignment.center,
                                                   children: [
                                                       Text(myprofile.get('name'),
                                                         style: TextStyle(
                                                           fontWeight: FontWeight.bold,
                                                           fontSize: 12,
                                                           color:   Colors.black.withOpacity(0.8)
                                                         ),
                                                       ),
                                                       SizedBox(height:4),
                                                       Text(myprofile.get('permanent_address'),
                                                         style: TextStyle(
                                                           fontWeight: FontWeight.w500,
                                                           fontSize: 13,
                                                           color: Colors.black.withOpacity(0.8),
                                                         ),
                                                       ),
                                                     SizedBox(height:4),
                                                       Text(myprofile.get('phone_number'),
                                                         style: TextStyle(
                                                           fontWeight: FontWeight.w500,
                                                           fontSize: 13,
                                                           color: Colors.black.withOpacity(0.8),
                                                         ),
                                                       ),

                                                   
                                                   ],
                                                 ),
                                               ),
                                                                             SizedBox(width: size.width*0.13,),
                                           Column(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             crossAxisAlignment: CrossAxisAlignment.end,
                                             children: [             
                                                 Text('Collect',
                                                   style: TextStyle(
                                                     fontWeight: FontWeight.w500,
                                                     fontSize: 13,
                                                     color: Colors.blue,
                                                   ),
                                                 ),

                                             
                                             ],
                                           )

                                             ],
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),
                                 )
                        
                              ;
            }


    );
                               
                         }
                         );
                         }
                         
                         return Text("");
                         }
                         ),
         
          ),
        ],
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
}
