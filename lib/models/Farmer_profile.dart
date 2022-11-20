import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class profileModel{
  String id;
  String name;
  String Email;
  // // File idproof;
  String phone_number;
  String additional_number;
  String permanent_address;
  String temporary_address;
  String migration_location;
  String number_of_beehive;
  String capacity_of_production;
  Timestamp date;
  String lat_long_location;
  String userId;
   

   profileModel(
    {
      required this.id,
      required this.name,
      required this.Email,
      required this.phone_number,
      required this.permanent_address,
      required this.temporary_address,
      required this.additional_number,
      required this.migration_location,
      required this.number_of_beehive,
      required this.capacity_of_production,
      required this.lat_long_location,
      required this.date,
      required this.userId,
    }
   );
   factory profileModel.fromJson(DocumentSnapshot  snapshot){
    return profileModel(
        id:snapshot.id,
        name:snapshot['name'],
        phone_number:snapshot['phone_number'],
        temporary_address:snapshot['temporary_address'],
        permanent_address:snapshot['permanent_address'],
        additional_number:snapshot['additional_number'],
        Email        :snapshot['email'],
        migration_location :snapshot['possible_migration'],
        number_of_beehive:snapshot['number_of_beehive'],
        capacity_of_production:snapshot['capacity_of_production'],
        date:snapshot['date'],
        userId:snapshot['userId'],
        lat_long_location:snapshot['lat_long_location'], 
    );
   }

}