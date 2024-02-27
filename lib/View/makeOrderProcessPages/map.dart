import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tager/Model/RequestModel.dart';

import '../../resourses/GoogleApiKey.dart';
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
    print("result");
    print(polylines_);

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
                      title: 'البدايه',
                      snippet: 'موقع ابتداء الرحله',
                    )),

              },
              initialCameraPosition: CameraPosition(
                target: MyLocation,
                zoom: 11.0,

              ),
            ),


          ],
        ),
      ),
    );
  }
}

