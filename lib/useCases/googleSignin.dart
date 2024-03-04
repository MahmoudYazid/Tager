

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:tager/View/trackGoodsAfterAccept/Check.dart';

void signInWithGoogle(context) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);


      Navigator.of(context).pushReplacement(

          MaterialPageRoute(builder: (context)=> CheckPage())
      );



  } on Exception catch (e) {
    // TODO
  }
}