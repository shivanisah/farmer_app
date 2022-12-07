// import 'dart:html';

import 'package:agriculture/AdminPages/CollectorMainPage.dart';
import 'package:agriculture/CollectorPages/Profile.dart';
import 'package:agriculture/FarmerPages/Profile.dart';
import 'package:agriculture/UsersPages/Admin.dart';
import 'package:agriculture/login.dart';
import 'package:agriculture/models/Farmer_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../FarmerPages/EditProfile.dart';


class FarmerList extends StatefulWidget {
  // const FarmerList({super.key});

  @override
  State<FarmerList> createState() => _FarmerListState();
}

class _FarmerListState extends State<FarmerList> {
        String MyEmail="";

    @override
   void initState(){
    farmer_profile();
    super.initState();
   }

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;

    return Scaffold(
                  drawer:
      Drawer(
        // width:250,
        backgroundColor:Color.fromARGB(253, 243, 242, 247),
        child:ListView(
          children: [
            UserAccountsDrawerHeader(
              
              accountName: Text("Hello"), accountEmail: Text(MyEmail),
            currentAccountPicture:
            CircleAvatar(backgroundColor:Colors.white,
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

      appBar: AppBar(
        title: Text("Admin"),
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
      SingleChildScrollView(
        scrollDirection:Axis.vertical,
        child: Column(
          children: [
            SizedBox(height:24),
                              Text("Farmers Logged In Detail",
      style: TextStyle(color:Colors.blueAccent,fontSize: 
                                      19,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 13,),
      
            Container(
              padding:EdgeInsets.only(top: 20,right:10),
              child:
               StreamBuilder(
                       stream:FirebaseFirestore.instance.collection('Farmers').snapshots(),
      
                       builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot2)
                       {
                         if(snapshot2.hasData){
      
                         return ListView.builder(
                           shrinkWrap: true,
                           itemCount: snapshot2.data!.docs.length,
                           itemBuilder: (context,index2){
                           DocumentSnapshot myprofile  = snapshot2.data!.docs[index2];
                           
                           print('....................................>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
                           print(myprofile.get('UserId'));
                          
      
                           // var user =collectorId.id ;
                           //      CollectionReference ref = FirebaseFirestore.instance.collection('users');
                           //                     ref.doc(user).get() ;
                               return  StreamBuilder(
              stream:FirebaseFirestore.instance.collection('Farmers_profile').where('userId',isEqualTo: myprofile['UserId']) .snapshots(),
      
              builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
              {
               if(snapshot.hasData){
                 if(snapshot.data!.docs.length>0){
               return ListView.builder(
                 shrinkWrap: true,
                 itemCount: snapshot.data!.docs.length,
                 itemBuilder: (context,index){
                 DocumentSnapshot farmerId = snapshot.data!.docs[index];
                 profileModel models = profileModel.fromJson(farmerId);
                  
                  
                 var obj='';
        
                   return  
                    GestureDetector(
                                   
                                     onTap:()async{
                                     
                                     await Navigator.push(context,
                                     MaterialPageRoute(
                                     builder: (context) =>EditFarmerProfile(models),
      
      
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
                                                         Text(myprofile .get('email'),
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
                                                   Text('Edit',
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
                                     builder: (context) => Profile(myprofile),
                                     settings: RouteSettings(arguments:myprofile .id ),
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
                                                         Text(myprofile .get('email'),
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
                                                   Text('Create',
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
