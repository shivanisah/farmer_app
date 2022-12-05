import 'package:cloud_firestore/cloud_firestore.dart';

class Collector_profile_model{
  String id;
  String full_name;
  String email;
  String phone_number;
  String UserId;
  String imageUrl;
  


Collector_profile_model({
  required this.full_name,
  required this.email,
  required this.phone_number,
  required this.UserId, 
  required this.id, 
  required this.imageUrl,
 
});


   factory Collector_profile_model.frommJson(DocumentSnapshot  snapshot){
    return Collector_profile_model(
      id:snapshot.id,
       full_name:snapshot['full_name'],
        // imagePath:snapshot['imagePath'],
        phone_number:snapshot['phone_number'],
        email:snapshot['email'],
        UserId: snapshot['UserId'],
        imageUrl:snapshot['imageUrl'],
        
    );
   }

}
