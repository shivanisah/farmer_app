
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
import 'CollectorMainPage.dart';


class CollectorNoprofile extends StatefulWidget {
  // const CollectorNoprofile({super.key});

  @override
  State<CollectorNoprofile> createState() => _CollectorNoprofileState();
}

class _CollectorNoprofileState extends State<CollectorNoprofile> {
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
        title: Text("Collectors"),
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
          SizedBox(height:20),
          Text("Farmers Profile Detail"),
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
                         
                         print('....................................>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
                         print(myprofile.get('userId'));
                        

                         // var user =collectorId.id ;
                         //      CollectionReference ref = FirebaseFirestore.instance.collection('users');
                         //                     ref.doc(user).get() ;
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
                                     height: 62,
                                   
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
                                           )
                                           ,
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                             
                                             children: [
                                               Padding(
                                                 padding: const EdgeInsets.only(left: 12),
                                                 child: Column(
                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                   crossAxisAlignment: CrossAxisAlignment.center,
                                                   children: [
                                                       Text('name',
                                                         style: TextStyle(
                                                           fontWeight: FontWeight.bold,
                                                           fontSize: 12,
                                                           color:   Colors.black.withOpacity(0.8)
                                                         ),
                                                       ),
                                                       // Text('',
                                                       //   style: TextStyle(
                                                       //     fontWeight: FontWeight.w500,
                                                       //     fontSize: 13,
                                                       //     color: Colors.black.withOpacity(0.4),
                                                       //   ),
                                                       // ),
                                                   
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
                                  //  settings: RouteSettings(arguments:myprofile .id ),
                                   // settings: RouteSettings(arguments:collectorId[index] ),


                                   )
                                   );


                                   },
                                   child: Container(
                                     margin: EdgeInsets.only(bottom: 15),
                                     height: 62,
                                   
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
                                           )
                                           ,
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                             
                                             children: [
                                               Padding(
                                                 padding: const EdgeInsets.only(left: 12),
                                                 child: Column(
                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                   crossAxisAlignment: CrossAxisAlignment.center,
                                                   children: [
                                                       Text('email',
                                                         style: TextStyle(
                                                           fontWeight: FontWeight.bold,
                                                           fontSize: 12,
                                                           color:   Colors.black.withOpacity(0.8)
                                                         ),
                                                       ),
                                                       // Text('',
                                                       //   style: TextStyle(
                                                       //     fontWeight: FontWeight.w500,
                                                       //     fontSize: 13,
                                                       //     color: Colors.black.withOpacity(0.4),
                                                       //   ),
                                                       // ),
                                                   
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
