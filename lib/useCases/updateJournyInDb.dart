import 'package:cloud_firestore/cloud_firestore.dart';


void Update(dynamic dataInput,String PhoneNumber , String EmailOfAccount){



  var docRef = FirebaseFirestore
      .instance
      .collection("orders")
  .doc(dataInput['id'])
  .update({'diverEmail' : EmailOfAccount,'diverNumber' : PhoneNumber});




}