import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../useCases/EndJourney.dart';
import '../../useCases/GetActiveRequestOfUser.dart';
import '../../useCases/searchUsercase.dart';
import '../../useCases/updateJournyInDb.dart';

class Track extends StatefulWidget {
  const Track({super.key});

  @override
  State<Track> createState() => _TrackState();
}

class _TrackState extends State<Track> {
  @override
  Widget build(BuildContext context) {
    String password ="0";
    return MaterialApp(
      home: Scaffold(

          body: StreamBuilder<QuerySnapshot>(
            stream: GetActiveRequestOfUser_f(),
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
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [


                        Text(" معك بضاعه للرقم")
                        ,Text(" "),

                        ],
                        
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        Text(snapshot.data!.docs[0]['requestOwnerNumber'].toString())
                      ],),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("لا يمكنك استعمال خصائص البرنامج حتي ايصال البضاعه")],),
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
                                          target: LatLng(double.parse(snapshot.data?.docs[0]['StartLat']), double.parse(snapshot.data?.docs[0]['StartLong'])),
                                          zoom: 11.0,

                                        ),
                                        markers: {
                                          Marker(
                                              markerId: MarkerId('بدايه الرحله'),
                                              position: LatLng(double.parse(snapshot.data?.docs[0]['StartLat']), double.parse(snapshot.data?.docs[0]['StartLong'])),
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
                                          target: LatLng(double.parse(snapshot.data?.docs[0]['EndLat']), double.parse(snapshot.data?.docs[0]['EndLong'])),
                                          zoom: 11.0,

                                        ),
                                        markers: {
                                          Marker(
                                              markerId: MarkerId('النهايه'),
                                              position: LatLng(double.parse(snapshot.data?.docs[0]['EndLat']), double.parse(snapshot.data?.docs[0]['EndLong'])),
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
                                          "الرقم السري مع العميل قم باستخدامه لانهاء الرحله",
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextField(

                                          onChanged: (e){
                                            setState(() {
                                              password=e;
                                            });
                                          },


                                          decoration: const InputDecoration(

                                            hintText:"الرقم السري",
                                            labelStyle: TextStyle(color: Colors.black),

                                            border: OutlineInputBorder(),


                                          ),
                                          textAlign: TextAlign.center,

                                        ),

                                        Visibility(
                                          visible: password.isNotEmpty? true:false,
                                          child: TextButton(

                                            onPressed: (){
                                              EndJourny(snapshot.data!.docs[0],password,context);
                                              //CheckPassword();
                                            },
                                            child: Text("فحص"),
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
                );
              }
            },
          )

      ),
    );
  }
}

