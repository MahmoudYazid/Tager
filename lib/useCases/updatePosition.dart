import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> updatePosition_F(String Long, String Lat) async {
  DocumentSnapshot<Object?> snapshot = await FirebaseFirestore.instance
      .collection('users_location_live')
      .doc(FirebaseAuth.instance.currentUser!.email.toString())
      .get();

  if (!snapshot.exists) {
    await FirebaseFirestore.instance
        .collection('users_location_live')
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .set({'lat': Lat, 'long': Long,'lastupdate':DateTime.now().toString()});
  } else {
    await FirebaseFirestore.instance
        .collection('users_location_live')
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .update({'lat': Lat, 'long': Long,'lastupdate':DateTime.now().toString()});
  }
}
