import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class FireStoreService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future createProfile(String name,String email,String phone_number,String additional_number,String permanent_address,String temporary_address,
                           String lat_and_long_location,String capacity_of_production,
  String possible_migration,String number_of_beehive,String userId) 
  async{
    try{
        await firestore.collection('Farmers_profile').add({
          "name":name,
          "email":email,
          "phone_number":phone_number,
          "additional_number":additional_number,
          "permanent_address":permanent_address,
          "temporary_address":temporary_address,
          "lat_long_location":lat_and_long_location,
          "capacity_of_production":capacity_of_production,
          "possible_migration":possible_migration,
          "number_of_beehive":number_of_beehive,
          "date":DateTime.now(),
          "userId":userId

        });
    }catch(e){

    }
  }


    Future updateFarmerProfile(String name,String email,String phone_number,String additional_number,String permanent_address,String temporary_address,
                           String lat_and_long_location,String capacity_of_production,
  String possible_migration,String number_of_beehive,String docId) 
  async{
    try{
        await firestore.collection('Farmers_profile').doc(docId).update({
          "name":name,
          "email":email,
          "phone_number":phone_number,
          "additional_number":additional_number,
          "permanent_address":permanent_address,
          "temporary_address":temporary_address,
          "lat_long_location":lat_and_long_location,
          "capacity_of_production":capacity_of_production,
          "possible_migration":possible_migration,
          "number_of_beehive":number_of_beehive,
          "date":DateTime.now(),
          "docId":docId

        });
    }catch(e){

    }
  }


  Future CollectorProfileCreate(String full_name,String email,String phone_number,String UserId,String imageUrl) 
  async{
    try{
        await firestore.collection('Collectors_profile').add({
          "full_name":full_name,
          "email":email,
          "phone_number":phone_number,
          "UserId":UserId,
          "imageUrl":imageUrl,

        });
    }catch(e){

    }
  }

      Future updateCollectorProfile(String full_name,String email,String phone_number,String docId) 
  async{
    try{
        await firestore.collection('Collectors_profile').doc(docId).update({
          "full_name":full_name,
          "email":email,
          "phone_number":phone_number,
          "date":DateTime.now(),
          "docId":docId

        });
    }catch(e){

    }
  }



Future addCollectionDetail(String number_of_receiver,String number_of_hive,String type_of_honey,String farmer_detail,
                            String collected_location,String moisture_report,String follow_of_status,String userId)
         async {
        try{
          await firestore.collection('Collection Details').add({
            "number_of_receiver":number_of_receiver,
            "number_of_hive":number_of_hive,            
            "type_of_honey":type_of_honey,
            "farmer_detail":farmer_detail,
            "collected_location":collected_location,
            "moisture_report":moisture_report,
            "follow_of_status":follow_of_status,
            "userId":userId,
            "date":DateFormat.yMMMEd().format(DateTime.now())+ DateFormat.jm().format(DateTime.now()),




          });

         } catch(e){

         }                    

         }
                            


}