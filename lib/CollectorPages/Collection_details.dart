import 'dart:async';

import 'package:agriculture/CollectorPages/Farmers_detail.dart';
import 'package:agriculture/CollectorPages/drawer.dart';
import 'package:agriculture/FarmerPages/Profile.dart';
import 'package:agriculture/models/Farmer_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../UsersPages/Collector.dart';
import '../Widgets/designcolor.dart';
import '../services/firestore_service.dart';

class CollectionDetailPage extends StatefulWidget {
  
   CollectionDetailPage({Key? key, }) : super(key: key);

  @override
  State<CollectionDetailPage> createState() => _CollectionDetailPageState();
}

class _CollectionDetailPageState extends State<CollectionDetailPage> {
  TextEditingController numberReceiverController =TextEditingController();
  TextEditingController numberHiveController =TextEditingController();
  TextEditingController honeyTypeController =TextEditingController();
  TextEditingController collectedLocationController =TextEditingController();
  TextEditingController moistureController =TextEditingController();
  TextEditingController followUpController =TextEditingController();
  TextEditingController farmerDetailController =TextEditingController();

  bool loading = false;
  var option = [
    'Item1',
    'Item2','item3','item4'
  ];
  var currentItemSelected = "Item1";
  var type_of_honey = "Item1";




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var time = DateTime.now();
    String formattedDate = DateFormat.yMMMEd().format(time);
    String formattedTime= DateFormat.jm().format(time);
    final  userId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      drawer:SideBar(),
    appBar:AppBar(title:Text("Collection Details")),  
  
    // body: Center(child: Text('this $userId')),
    body:
          SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [

                            Text("Collection Details for UserId: $userId",
style: TextStyle(color: Palette.lightPurple,fontSize: 
                                    19,fontWeight: FontWeight.bold),),
                                    SizedBox(height: 17,),

            Container(
              
              child:Form(
                child:Column(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: [

                    
                                                       SizedBox(height: 10,),

                                        Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    padding: EdgeInsets.only(left: 4,top:1,bottom: 4,right: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(29),
                                      boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0,0),
                                                      blurRadius: 5,
                                                      color:Colors.black.withOpacity(0.2),
                                      
                                                    )
                                                  ]
                                    ),
                                    child:TextFormField(
                                   keyboardType:TextInputType.multiline,
                                      maxLines:5,           

                                      controller:numberReceiverController,

                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.76),
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          // floatingLabelAlignment: FloatingLabelAlignment.start,
                                          // // floatingLabelBehavior: FloatingLabelBehavior.always,
                                          // labelStyle: TextStyle(color: Palette.lightPurple,fontSize: 19),
                                          hintText: 'Receiver Detail',
                                          
                                          hintStyle: TextStyle(
                                            color: Colors.black.withOpacity(0.6)
                                          ),
                                         
                                          
                                          enabled: true,
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0, bottom: 8.0, top: 8.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                        ),
                                    ),
                                     
                                    
                                    ),SizedBox(height: 22,),

                                                            Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    padding: EdgeInsets.only(left: 4,top:1,bottom: 4,right: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(29),
                                      boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0,0),
                                                      blurRadius: 5,
                                                      color:Colors.black.withOpacity(0.2),
                                      
                                                    )
                                                  ]
                                    ),
                                    child:TextFormField(
                                     keyboardType:TextInputType.number,
                                     controller:numberHiveController,


                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.76),
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'Number of hive',
                                          
                                          hintStyle: TextStyle(
                                            color: Colors.black.withOpacity(0.6)
                                          ),
                                         
                                          
                                          enabled: true,
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0, bottom: 8.0, top: 8.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                        ),
                                    ),
                                     
                                    
                                    ),SizedBox(height: 22,),
                                                            Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    padding: EdgeInsets.only(left: 4,top:1,bottom: 4,right: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(29),
                                      boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0,0),
                                                      blurRadius: 5,
                                                      color:Colors.black.withOpacity(0.2),
                                      
                                                    )
                                                  ]
                                    ),
                                    child:TextFormField(


                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.76),
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText:"$formattedDate $formattedTime",
                                          
                                          enabled:false,

                                          hintStyle: TextStyle(
                                            color: Colors.black.withOpacity(0.6),
                                            fontWeight: FontWeight.bold,
                                          ),
                                         
                                          
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0, bottom: 8.0, top: 8.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                        ),
                                    ),
                                     
                                    
                                    ),SizedBox(height: 22,),

                                                            Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    padding: EdgeInsets.only(left: 4,top:1,bottom: 4,right: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(29),
                                      boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0,0),
                                                      blurRadius: 5,
                                                      color:Colors.black.withOpacity(0.2),
                                      
                                                    )
                                                  ]
                                    ),
                          child:DropdownButtonFormField2<String>(
                                
                                      
                                      decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          
                                        ),
                                      scrollbarAlwaysShow: true,
                                      buttonHeight: 22,
                                      itemSplashColor:Palette.lightPurple,
                                      dropdownPadding: EdgeInsets.all(15),
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius:BorderRadius.circular(17),
                                        ),

                                      isExpanded: true,
                                      // iconEnabledColor: Colors.white,
                                      focusColor: Colors.white,
                                      items: option.map((String dropDownItem) {
                                        return DropdownMenuItem<String>(
                                          
                                          value: dropDownItem,
                                          child: Text(
                                            dropDownItem,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValueSelect) {
                                        
                                    setState(() {
                                      currentItemSelected = newValueSelect!;
                                      type_of_honey = newValueSelect;
                                    });
                                          },
                                      value: currentItemSelected,
                                    ),
 
                                    
                                    ),SizedBox(height: 22,),


                  
                                                            Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    padding: EdgeInsets.only(left: 4,top:1,bottom: 4,right: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(29),
                                      boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0,0),
                                                      blurRadius: 5,
                                                      color:Colors.black.withOpacity(0.2),
                                      
                                                    )
                                                  ]
                                    ),
                                    child:TextFormField(
                                    controller: farmerDetailController,
                                    keyboardType: TextInputType.multiline,
                                    maxLines:4,


                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.76),
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'Farmers Detail',
                                          
                                          hintStyle: TextStyle(
                                            color: Colors.black.withOpacity(0.6)
                                          ),
                                         
                                          
                                          enabled: true,
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0, bottom: 8.0, top: 8.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                        ),
                                    ),
                                     
                                    
                                    ),SizedBox(height: 22,),
                                                            Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    padding: EdgeInsets.only(left: 4,top:1,bottom: 4,right: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(29),
                                      boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0,0),
                                                      blurRadius: 5,
                                                      color:Colors.black.withOpacity(0.2),
                                      
                                                    )
                                                  ]
                                    ),
                                    child:TextFormField(
                                     controller:collectedLocationController,


                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.76),
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'Collected Location',
                                          
                                          hintStyle: TextStyle(
                                            color: Colors.black.withOpacity(0.6)
                                          ),
                                         
                                          
                                          enabled: true,
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0, bottom: 8.0, top: 8.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                        ),
                                    ),
                                     
                                    
                                    ),SizedBox(height: 22,),
                                                            Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    padding: EdgeInsets.only(left: 4,top:1,bottom: 4,right: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(29),
                                      boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0,0),
                                                      blurRadius: 5,
                                                      color:Colors.black.withOpacity(0.2),
                                      
                                                    )
                                                  ]
                                    ),
                                    child:TextFormField(
                                      controller: moistureController,


                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.76),
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'Moisture Report',
                                          
                                          hintStyle: TextStyle(
                                            color: Colors.black.withOpacity(0.6)
                                          ),
                                         
                                          
                                          enabled: true,
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0, bottom: 8.0, top: 8.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                        ),
                                    ),
                                     
                                    
                                    ),SizedBox(height: 22,),
                                                            Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    padding: EdgeInsets.only(left: 4,top:1,bottom: 4,right: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(29),
                                      boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0,0),
                                                      blurRadius: 5,
                                                      color:Colors.black.withOpacity(0.2),
                                      
                                                    )
                                                  ]
                                    ),
                                    child:TextFormField(
                                    controller:followUpController,


                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.76),
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'Follow up status',
                                          
                                          hintStyle: TextStyle(
                                            color: Colors.black.withOpacity(0.6)
                                          ),
                                         
                                          
                                          enabled: true,
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0, bottom: 8.0, top: 8.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.transparent),
                                            borderRadius: new BorderRadius.circular(29),
                                          ),
                                        ),
                                    ),
                                     
                                    
                                    ),SizedBox(height: 22,),
         

            loading?Center(child:CircularProgressIndicator(),):Container(
                    

                    child: MaterialButton(
                       minWidth: size.width*0.55,
                        height: 47,
                       color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                     elevation: 18.0,
                      onPressed:()async{
                      if(numberReceiverController.text==""|| numberHiveController.text==""||farmerDetailController.text==""
                      ||  collectedLocationController.text==""|| moistureController.text==""|| followUpController.text==""
                      ){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("All fields are required"),backgroundColor:Colors.red));
                      }else{
                        setState(() {
                          loading=true;
                        });
                       
                        await FireStoreService().addCollectionDetail(numberReceiverController.text,numberHiveController.text,type_of_honey,farmerDetailController.text,collectedLocationController.text,moistureController.text,
                        followUpController.text,userId);
                        setState(() {
                          loading=false;
                        });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Collection done successfully"),backgroundColor:Colors.green));

                        Timer(Duration(seconds: 2),(){
                         Navigator.push(context,MaterialPageRoute(builder:(context)=>Farmers_Detail()));


                        });
  

                      }


                    },
                    child:Text("Save",style: new TextStyle(fontSize: 20.0, color: Colors.white)),
                    
                    ),
                  ),
                ],)
              )
    
            )
          ],),
        )
      ),

    );
    
  }
}