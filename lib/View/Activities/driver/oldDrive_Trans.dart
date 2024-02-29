import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../useCases/getDataFromFirebaseOnUserTransactions.dart';
import '../Activities.dart';

class OldDriveTrans extends StatefulWidget {
  const OldDriveTrans({super.key});

  @override
  State<OldDriveTrans> createState() => _OldDriveTransState();
}

class _OldDriveTransState extends State<OldDriveTrans> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){

              Navigator.of(context).pushReplacement(

                  MaterialPageRoute(builder: (context)=> Activities())
              );
            },
            icon: Icon(Icons.arrow_back_outlined),
          ),
        ),
          body: StreamBuilder<QuerySnapshot>(
            stream: GetDataAsDriver(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while waiting for data
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Display an error message if there's an error with the stream
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                // Display a message when there is no data available
                return Center(child: Text('لا يوجد عمليات سابقه',style: TextStyle(fontSize: 25.sp)));
              } else {
                // If snapshot data is available, build the ListView
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    var imgtype = doc['Type'];
                    var ClientEmailVar = (doc['requestOwnerEmail'] == null || doc['requestOwnerEmail'].toString() == "null")
                        ? 'لا يوجد عميل حتى الآن'
                        : doc['requestOwnerEmail'];
                    var ClientNumVar = (doc['requestOwnerNumber'] == null || doc['requestOwnerNumber'].toString() == "null")
                        ? 'لا يوجد عميل حتى الآن'
                        : doc['requestOwnerNumber'];
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
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "ايميل العميل",
                                                      style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      ClientEmailVar,
                                                      style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      "هاتف العميل",
                                                      style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      ClientNumVar,
                                                      style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.drive_eta),
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
