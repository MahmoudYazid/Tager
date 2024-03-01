import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tager/Model/RequestModel.dart';
import 'package:tager/View/makeOrderProcessPages/to_where_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../resourses/GoogleApiKey.dart';

import 'OkStatusPage.dart';
// api key : AIzaSyA0T-3Pn3rAnONefJFmd8RzON1Q97inwt0
class MapClassForOrder extends StatefulWidget {
  const MapClassForOrder(

      {
        super.key,
        required this.request,
        required this.polylines



      }


      );
  final RequestModel request;
  final Map<PolylineId, Polyline> polylines;

  @override
  State<MapClassForOrder> createState() => _MapClassState(request,polylines);
}

class _MapClassState extends State<MapClassForOrder> {
  late GoogleMapController mapController;
  late RequestModel _request;
  late Map<PolylineId, Polyline> polylines_;





  @override
  void initState() {

    super.initState();
    _request = widget.request;
    polylines_ = widget.polylines;


  }



  _MapClassState(RequestModel request, Map<PolylineId, Polyline> polylines);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;


  }
  @override
  Widget build(BuildContext context) {
    double startLat_ext = double.parse(_request.StartLat.toString());
    double StartLong_ext = double.parse(_request.StartLong.toString());
    LatLng MyLocation = LatLng(startLat_ext, StartLong_ext);
    double EndLat_ext = double.parse(_request.EndLat.toString());
    double EndLong_ext = double.parse(_request.EndLong.toString());
    LatLng Target = LatLng(EndLat_ext, EndLong_ext);

    // add polyLines




    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text("تاكد من الطلب",style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.black,
            leading: IconButton(
              onPressed: (){
                Navigator.of(context).pushReplacement(

                    MaterialPageRoute(builder: (context)=> ToWherePage())
                );
              },
              icon: Icon(Icons.arrow_back_outlined,color: Colors.white,),
            ),
          actions: [
            IconButton(
              onPressed: (){

                // add to firebase
                var Dbinst =FirebaseFirestore.instance.collection("orders");


                Dbinst.doc(_request.id).set(_request.toMap()).then((value) =>

                    Navigator.of(context).pushReplacement(

                        MaterialPageRoute(builder: (context)=> OkStatus())
                    )
                );

                // go to okStatus Page

              },
              icon: Icon(Icons.check,color: Colors.white,),
            ),
            IconButton(
              onPressed: (){
                mapController.moveCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(target: Target,
                    zoom: 15.0
                    )
                ));

              },
              icon: Icon(Icons.location_on,color: Colors.white,),
            ),
            IconButton(
              onPressed: (){
                mapController.moveCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(target: MyLocation,
                        zoom: 15.0
                    )
                ));

              },
              icon: Icon(Icons.my_location,color: Colors.white,),
            )
          ],
        ),

        body: Stack(
          children: [

            GoogleMap(
              onMapCreated: _onMapCreated,
              polylines: Set<Polyline>.of(polylines_.values),
          markers: {
            Marker(
            markerId: MarkerId('myMarker'),
            position: MyLocation,
            infoWindow: InfoWindow(
            title: 'البدايه',
            snippet: 'موقع ابتداء الرحله',
            )),
                Marker(
                    markerId: MarkerId('TargetMarker'),
                    position: Target,
                    infoWindow: InfoWindow(
                      title: 'نهايه الرحله',
                      snippet: 'نهايه الرحله',
                    )),

              },
              initialCameraPosition: CameraPosition(
                target: Target,
                zoom: 5.0,

              ),

            ),
            Positioned(
                bottom:0 ,
                left: 0,
                right: 0,
                child:
            Container(

              margin: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h),
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.dg)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Text("سعر الرحله"),
                  Text(_request.Cash, textAlign: TextAlign.center),
                  Text("الوجهه"),
                  Text(_request.TargetPlaceName, textAlign: TextAlign.center),
                  Text("الرحله تبدا من"),
                  Text(_request.StartPlaceName, textAlign: TextAlign.center),
                  Text("طول الرحله"),
                  Text(_request.Km, textAlign: TextAlign.center),


                ],
              ),

            ))


          ],
        ),
      ),
    );
  }
}

