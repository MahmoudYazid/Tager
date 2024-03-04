import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tager/View/searchForOrder/searchForOrder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tager/View/trackGoodsAfterAccept/Track.dart';

import '../../useCases/searchUsercase.dart';
import '../../useCases/updateJournyInDb.dart';

class Result extends StatefulWidget {
  const Result({
    
    super.key,
    required this.place,
    required this.TypeChoosen,



  });
  final String place;
  final String TypeChoosen;
  @override
  State<Result> createState() => _ResultState(place,TypeChoosen);
}

class _ResultState extends State<Result> {
  late String place_;
  late String TypeChoosen_;
  _ResultState(String place, String typeChoosen);
  @override
  void initState() {

    super.initState();
    place_ = widget.place;
    TypeChoosen_ = widget.TypeChoosen;


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){

                Navigator.of(context).pushReplacement(

                    MaterialPageRoute(builder: (context)=> seachForOrder())
                );
              },
              icon: Icon(Icons.arrow_back_outlined),
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: GetofSearchFunctions(place_,TypeChoosen_),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while waiting for data
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Display an error message if there's an error with the stream
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                // Display a message when there is no data available
                return Center(child: Text('لا يوجد عمليات سابقه',style: TextStyle(fontSize: 25.sp),));
              } else {
                // If snapshot data is available, build the ListView
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    var imgtype = doc['Type'];
                    var DriverNumber="";
                    return Container(
                      width: double.infinity,
                      height: 150.h,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey, // Color of the bottom border
                            width: 2.0, // Width of the bottom border
                            style: BorderStyle.solid, // Style of the bottom border
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(doc['Km'] + " " + "كيلومتر"),

                                  Text(doc['Cash'] + " " + "ريال"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.0),
                                                topRight: Radius.circular(10.0),
                                              ),
                                            ),
                                            builder: (BuildContext context) {
                                              return Container(
                                                  width: double.infinity,
                                                  child:     GoogleMap(
                                                    initialCameraPosition: CameraPosition(
                                                      target: LatLng(double.parse(doc['StartLat']), double.parse(doc['StartLong'])),
                                                      zoom: 11.0,

                                                    ),
                                                    markers: {
                                                      Marker(
                                                          markerId: MarkerId('بدايه الرحله'),
                                                          position: LatLng(double.parse(doc['StartLat']), double.parse(doc['StartLong'])),
                                                          infoWindow: InfoWindow(
                                                            title: 'البدايه',
                                                            snippet: 'موقع البدايه',
                                                          ))
                                                    },

                                                  )
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.gps_not_fixed),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.0),
                                                topRight: Radius.circular(10.0),
                                              ),
                                            ),
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: double.infinity,
                                                child:     GoogleMap(
                                                  initialCameraPosition: CameraPosition(
                                                    target: LatLng(double.parse(doc['EndLat']), double.parse(doc['EndLong'])),
                                                    zoom: 11.0,

                                                  ),
                                                  markers: {
                                                    Marker(
                                                        markerId: MarkerId('النهايه'),
                                                        position: LatLng(double.parse(doc['EndLat']), double.parse(doc['EndLong'])),
                                                        infoWindow: InfoWindow(
                                                          title: 'الهدف',
                                                          snippet: 'موقع النهايه',
                                                        ))
                                                  },

                                                )
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.gps_fixed),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.0),
                                                topRight: Radius.circular(10.0),
                                              ),
                                            ),
                                            builder: (BuildContext context) {
                                              return Container(
                                                padding: EdgeInsets.all(15),
                                                width: double.infinity,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "هل انت متاكد من انك تريد تسجيل اسمك في هذه الرحله",
                                                      style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    TextField(

                                                      onChanged: (e){
                                                        setState(() {
                                                          DriverNumber=e;
                                                        });
                                                      },


                                                      decoration: const InputDecoration(

                                                        hintText:"رقم الهاتف",
                                                        labelStyle: TextStyle(color: Colors.black),

                                                        border: OutlineInputBorder(),


                                                      ),
                                                      textAlign: TextAlign.center,

                                                    ),

                                                   Visibility(
                                                     visible: DriverNumber.isNotEmpty? true:false,
                                                     child: TextButton(

                                                        onPressed: (){

                                                          Update(doc,DriverNumber,FirebaseAuth
                                                              .instance.currentUser!
                                                              .email.toString());
                                                          Navigator.of(context).pushReplacement(

                                                              MaterialPageRoute(builder: (context)=> Track())
                                                          );
                                                        },
                                                        child: Text("اوافق"),
                                                      ),
                                                   ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.check),
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Image(
                              image: AssetImage('assets/src/$imgtype.png'),
                              width: 50.w,
                              height: 50.h,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    doc['TargetPlaceName'],
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            },
          )

      ),
    );
  }
}
