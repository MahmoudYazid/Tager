import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/RequestModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
Stream<QuerySnapshot<Map<String, dynamic>>>? GetActiveRequestOfUser_f(){
  var data= FirebaseFirestore
      .instance
      .collection("orders")
      .where("diverEmail",isEqualTo: FirebaseAuth.instance.currentUser!.email.toString())
      .where("status",isEqualTo: "in process")
      .snapshots();

  if(data != null){
    return data;
  }else{
    return Stream.empty();
  }
      
  
}

Future<bool> GetActiveRequestOfUserSignal_f() async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection("orders")
      .where("diverEmail", isEqualTo: FirebaseAuth.instance.currentUser!.email.toString())
      .where("status", isEqualTo: "in process")
      .get();

  return querySnapshot.docs.isNotEmpty;
}