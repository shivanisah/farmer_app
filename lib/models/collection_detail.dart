import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionDetails{
  String number_of_receiver;
  String number_of_hive;
  String collected_location;
  String moisture_report;
  String follow_of_status;
  String type_of_honey;
  String farmer_detail;
  String userId;
  Timestamp date;


CollectionDetails({
  required this.number_of_receiver,
  required this.number_of_hive,
  required this.collected_location,  
  required this.moisture_report,  
  required this.follow_of_status,  
  required this.type_of_honey,
  required this.farmer_detail, 
  required this.userId, 
  required this.date,
});
}
