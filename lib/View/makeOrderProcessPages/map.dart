import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tager/Model/RequestModel.dart';
// api key : AIzaSyA0T-3Pn3rAnONefJFmd8RzON1Q97inwt0
class MapClassForOrder extends StatefulWidget {
  const MapClassForOrder(

      {
        super.key,
       required this.request



      }


      );
  final RequestModel request;
  @override
  State<MapClassForOrder> createState() => _MapClassState(request);
}

class _MapClassState extends State<MapClassForOrder> {
  late GoogleMapController mapController;
  late RequestModel _request;
  @override
  void initState() {
    super.initState();
    _request = widget.request;
  }

  final LatLng _center = const LatLng(45.521563, -122.677433);

  _MapClassState(RequestModel request);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;


  }
  @override
  Widget build(BuildContext context) {
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
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),


          ],
        ),
      ),
    );
  }
}

