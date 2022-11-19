import 'package:agriculture/FarmerPages/Profile.dart';
import 'package:agriculture/models/Farmer_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../UsersPages/Collector.dart';
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
  bool loading = false;
  var option = [
    'Item1',
    'Item2','item3','item4'
  ];
  var currentItemSelected = "Item1";
  var type_of_honey = "Item1";




  @override
  Widget build(BuildContext context) {
    final  userId = ModalRoute.of(context)!.settings.arguments as String;
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
        // print(farmerData);
        // final data= profileModel.frommJson(farmerData);
        // print(data.Email);

    return Scaffold(
    appBar:AppBar(title:Text("Collection Details")),  
  
    // body: Center(child: Text('this $userId')),
    body:
          SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Container(
              
              child:Form(
                child:Column(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: [
                    SizedBox(height:10),
                  Text(
                    "Collection Details for UserId: $userId",
                    style:TextStyle(
                      fontSize:20,
                      fontWeight:FontWeight.bold,
                    )
                    ),
                    SizedBox(height:20),
                  TextFormField(
                    keyboardType:TextInputType.number,
                    controller:numberReceiverController,
                    decoration:InputDecoration(
                    labelText:"Number of receiver",
                      // icon: Icon(Icons.group)

                    )
                  ),
              SizedBox(height:20),
                                TextFormField(
                  keyboardType:TextInputType.number,
                  controller:numberHiveController,
                    decoration:InputDecoration(
                    labelText:"Number of hive",
                      // icon: Icon(Icons.email)

                    )
                  ),
              SizedBox(height:20),
                              DropdownButtonFormField<String>(
                                decoration:InputDecoration(
                                  labelText:"Select honey type"
                                ),

                                // dropdownColor: Colors.blue[900],
                                // isDense: true,
                                // isExpanded: false,
                                // iconEnabledColor: Colors.white,
                                // focusColor: Colors.white,
                                items: option.map((String dropDownItem) {
                                  return DropdownMenuItem<String>(

                                    value: dropDownItem,
                                    child: Text(
                                      dropDownItem,
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

//                     TextFormField(
//     controller: honeyTypeController,
//     keyboardType: TextInputType.number,

//     decoration: InputDecoration(
//         labelText:"Select honey type", 
//         // icon: Icon(Icons.phone_android_outlined)
//     )
// ),
              SizedBox(height:20),
                                TextFormField(
                    controller:collectedLocationController,
                    decoration:InputDecoration(
                    labelText:"Collected Location",
                      // icon: Icon(Icons.phone)

                    )
                  ),
              SizedBox(height:20),


  TextFormField(
    controller: moistureController,
    

    decoration: InputDecoration(
        labelText:"Moisture report", 
        // icon: Icon(Icons.home)
    )
),
                  SizedBox(
                    height:20,
                  ),

                  TextFormField(
                    controller:followUpController,
                    decoration:InputDecoration(
                   labelText:"Follow up Status",
                      // icon: Icon(Icons.location_city),
                      fillColor: Colors.red

                    )

                  ),
                 

              SizedBox(height:20),


         

            loading?Center(child:CircularProgressIndicator(),):Container(
                    child: ElevatedButton(onPressed:()async{
                      if(numberReceiverController.text==""|| numberHiveController.text==""
                      ||  collectedLocationController.text==""|| moistureController.text==""|| followUpController.text==""
                      ){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("All fields are required"),backgroundColor:Colors.red));
                      }else{
                        setState(() {
                          loading:true;
                        });
                       
                        await FireStoreService().addCollectionDetail(numberReceiverController.text,numberHiveController.text,type_of_honey,collectedLocationController.text,moistureController.text,
                        followUpController.text,userId);
                        setState(() {
                          loading=false;
                        });
                        Navigator.push(context,MaterialPageRoute(builder:(context)=>Collector()));
                      }


                    },
                    child:Text("Save"),),
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