import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tager/View/Activities/sender/oldsend_trans.dart';
import 'package:tager/useCases/getMyGoodsPosition.dart';
class GetMyProductPosition extends StatefulWidget {
  const GetMyProductPosition({
    Key? key,
    required this.TargetEmail


  }) : super(key: key);
  final String TargetEmail;
  @override
  _GetMyProductPositionState createState() => _GetMyProductPositionState(TargetEmail);
}

class _GetMyProductPositionState extends State<GetMyProductPosition> {
  late GoogleMapController mapController;

  String EmailNeeded="";

  _GetMyProductPositionState(String targetEmail);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EmailNeeded=widget.TargetEmail;
  }

  @override
  Widget build(BuildContext context) {
    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){

                Navigator.of(context).pushReplacement(

                    MaterialPageRoute(builder: (context)=> OldsendTrans())
                );
              },
              icon: Icon(Icons.arrow_back_outlined),
            ),
          ),
          body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: GetMyProductPosition_f(EmailNeeded),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while waiting for data
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Display an error message if there's an error with the stream
                return Center(child: Text('Error: ${snapshot.error}'));
              }  else {
                // If snapshot data is available, build the ListView
                return Container(
                  child:   GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(double.parse(snapshot.data!.data()?['lat']), double.parse(snapshot.data!.data()?['long'])),
                      zoom: 11.0,
                    ),
                    markers: {
                      Marker(
                          markerId: MarkerId('البضاعه'),
                          position: LatLng(double.parse(snapshot.data!.data()?['lat']), double.parse(snapshot.data!.data()?['long'])),
                          infoWindow: InfoWindow(
                            title: 'موقع البضاعه',
                            snippet: 'موقع البضاعه',
                          )),

                    },
                  ),

                );
              }
            },
          )

      ),
    );
  }
}
