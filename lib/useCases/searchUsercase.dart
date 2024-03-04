import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Stream<QuerySnapshot<Map<String, dynamic>>>  GetofSearchFunctions(String targetPlaceNameInput , String TypeOfTrans){
  var res =FirebaseFirestore
      .instance
      .collection("orders")
      .where("TargetPlaceName", isGreaterThanOrEqualTo: targetPlaceNameInput)
      .where("Type",isEqualTo: TypeOfTrans)
      .where("diverEmail",isEqualTo: "null")
      .where("diverNumber",isEqualTo: "null")

      .snapshots();
  if (res != null) {
    return res;
  } else {
    return Stream.empty();
  }

}