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

   factory CollectionDetails.fromJson(DocumentSnapshot  snapshot){
    return CollectionDetails(
        number_of_receiver:snapshot['number_of_receiver'],
        // imagePath:snapshot['imagePath'],
        number_of_hive:snapshot['number_of_hive'],
        collected_location:snapshot['collected_location'],
        moisture_report:snapshot['moisture_report'],
        follow_of_status:snapshot['follow_of_status'],
        type_of_honey       :snapshot['type_of_honey'],
        farmer_detail :snapshot['farmer_detail'],
        date:snapshot['date'],
        userId:snapshot['userId'],
    );
   }

}
