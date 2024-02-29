import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Stream<QuerySnapshot<Map<String, dynamic>>>  GetDataAsDriver(){
  final currentUser = FirebaseAuth.instance.currentUser;
  var res =FirebaseFirestore
      .instance
      .collection("orders")
      .where("diverEmail", isEqualTo: currentUser?.email)
      .snapshots();
  if (res != null) {
    return res;
  } else {
    return Stream.empty();
  }

}
Stream<QuerySnapshot<Map<String, dynamic>>>  GetDataAsOwner(){
  final currentUser = FirebaseAuth.instance.currentUser;

  var res =FirebaseFirestore
      .instance
      .collection("orders")
      .where("requestOwnerEmail",isEqualTo:currentUser?.email )

      .snapshots();
  if (res != null) {
    return res;
  } else {
    return Stream.empty();
  }

}