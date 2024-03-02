
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tager/View/home.dart';


void EndJourny(dynamic dataInput,String Password,context){
  if (Password==dataInput['id']) {

    var docRef = FirebaseFirestore
        .instance
        .collection("orders")
        .doc(dataInput['id'])
        .update({'status':'end'});

    Navigator.of(context).pushReplacement(

        MaterialPageRoute(builder: (context)=> Home())
    );
  }






}