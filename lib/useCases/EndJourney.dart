
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tager/View/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> EndJourny(dynamic dataInput,String Password,context,timer) async {
  if (Password==dataInput['id']) {

    var docRef = FirebaseFirestore
        .instance
        .collection("orders")
        .doc(dataInput['id'])
        .update({'status':'end'});

    timer?.cancel();
    await FirebaseFirestore.instance
        .collection('users_location_live')
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .delete();

    Navigator.of(context).pushReplacement(

        MaterialPageRoute(builder: (context)=> Home())
    );

  }






}