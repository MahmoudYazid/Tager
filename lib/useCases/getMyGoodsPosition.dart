import 'package:cloud_firestore/cloud_firestore.dart';

Stream<DocumentSnapshot<Map<String, dynamic>>> GetMyProductPosition_f(String Email)  {
  return  FirebaseFirestore.instance
      .collection("users_location_live")
      .doc(Email)
      .snapshots();
}
