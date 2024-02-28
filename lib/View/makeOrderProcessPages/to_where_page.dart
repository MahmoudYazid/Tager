import 'dart:ffi';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tager/Model/RequestModel.dart';
import 'package:tager/View/home.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:tager/View/makeOrderProcessPages/map.dart';
import 'package:tager/resourses/GoogleApiKey.dart';
import '../../Model/AutoCompleteResp.dart';
import '../../useCases/GetMyLocation.dart';
import '../../useCases/Calculate_Cash.dart';
class ToWherePage extends StatefulWidget {
  const ToWherePage({Key? key}) : super(key: key);

  @override
  _ToWherePageState createState() => _ToWherePageState();
}

class _ToWherePageState extends State<ToWherePage> {
  Future<AutoCompleteResp?> recommendationData = Future.value(null);
  String SelectedLat = "";
  String SelectedLong = "";
  String TargetAreaText = "";
  String Type_ofTrans="";
  bool ToastVisibilty =false;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  TextEditingController controller = TextEditingController();
  bool clicked=false;
  String MyplaceName='';

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.blue, points: polylineCoordinates);

    polylines[id] = polyline;

  }

  _getPolyline(
      double startLat_ext,
      double StartLong_ext,
      double EndLat_ext,
      double EndLong_ext,



      ) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        GoogleApikeyInst,
        PointLatLng(startLat_ext, StartLong_ext),
        PointLatLng(EndLat_ext, EndLong_ext),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {

        polylineCoordinates.add(LatLng(point.latitude, point.longitude));



      });
    }
    _addPolyLine();
  }



  @override
  Widget build(BuildContext context) {

    return  FutureBuilder<AutoCompleteResp?>(
      future:recommendationData ,
      builder: (context, snapshot) {
        // get current position



        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("اختار المكان",style: TextStyle(color: Colors.white),),
              backgroundColor: Colors.black,
              leading: IconButton(
                onPressed: (){
                  Navigator.of(context).pushReplacement(

                      MaterialPageRoute(builder: (context)=> Home())
                  );
                },
                icon: Icon(Icons.arrow_back_outlined,color: Colors.white,),
              ),



            ),
            body: SafeArea(
              child: Column(
                children: [
                  Container(

                    margin: EdgeInsets.only(left: 20.w,right: 20.w,top: 20.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),

                    ),

                    child:     GooglePlacesAutoCompleteTextFormField(
                        textEditingController: controller,
                        onChanged:(e){
                          setState(() {
                            TargetAreaText=e;
                          });

                        }
                        ,googleAPIKey: GoogleApikeyInst,
                        debounceTime: 400, // defaults to 600 ms
                        isLatLngRequired: true, // if you require the coordinates from the place details
                        getPlaceDetailWithLatLng: (prediction) {
                          SelectedLat= prediction.lat.toString();
                          SelectedLong= prediction.lng.toString();
                        }, // this callback is called when isLatLngRequired is true
                        itmClick: (prediction) {
                          controller.text = prediction.description.toString();
                          controller.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description!.length));
                        },
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'ادخل موقع التوصيل',

                        labelStyle: TextStyle(color: Colors.purple),
                        border: OutlineInputBorder(),

                      ),

                    )
                  ),
                  Expanded(
                    child:GridView.count(crossAxisCount: 2,
                    children: [
                      TextButton(
                        onPressed: (){
                          setState(() {
                            Type_ofTrans="goods";
                          });
                        }
                        ,child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Image(
                              image: AssetImage('assets/src/goods.png'),
                              width: 100.w,
                              height: 100.h,

                            ),
                            Text("بضاعه",
                              style: TextStyle(
                                  color: Type_ofTrans == "goods"?Colors.blue : Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500
                              ),)
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          setState(() {
                            Type_ofTrans="furniture";
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/src/furniture.png'),
                              width: 100.w,
                              height: 100.h,
                            ),
                            Text("اثاث",
                              style: TextStyle(
                                  color: Type_ofTrans == "furniture"?Colors.blue : Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500
                              ),)
                          ],
                        ),
                      ),
                      TextButton(

                        onPressed: (){
                          setState(() {
                            Type_ofTrans="satha";
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/src/satha.png'),
                              width: 100.w,
                              height: 100.h,
                            ),
                            Text("سطحه",
                              style: TextStyle(
                                  color: Type_ofTrans == "satha"?Colors.blue : Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500
                              ),)
                          ],
                        ),
                      ),
                      TextButton(

                        onPressed: () async{
                         // calc distance

                          if(TargetAreaText !="" && Type_ofTrans!="" && TargetAreaText.isEmpty==false && Type_ofTrans.isEmpty==false) {
                            Position MyPosition = await determinePosition();
                            double StartLongDouble=MyPosition.longitude.toDouble();
                            double StartlatDouble=MyPosition.latitude.toDouble();
                            double EndLongDouble = double.parse(SelectedLong);
                            double EndlatDouble = double.parse(SelectedLat);
                            double Dist =Geolocator.distanceBetween(

                                StartlatDouble,
                                StartLongDouble,
                                EndlatDouble.toDouble(),
                                EndLongDouble.toDouble()
                            )/1000;
                            double CorrectDist = Dist + (Dist * .20) ;

                            String FinalCash= CalculateCash(CorrectDist.toInt(),Type_ofTrans);

                            // get polyLines
                            _getPolyline(
                                StartlatDouble,
                                StartLongDouble,
                                EndlatDouble.toDouble(),
                                EndLongDouble.toDouble()
                            );
                            setState(() {
                              clicked=true;
                            });

                            // get my place name
                            List<Placemark> placemarks = await placemarkFromCoordinates(
                                StartlatDouble, StartLongDouble);
                            Placemark placemark = placemarks[0];
                            setState(() {

                              String formattedAddress = ' ${placemark.locality ?? 'N/A'},${placemark.subLocality ?? 'N/A'}, ${placemark.thoroughfare ?? 'N/A'}, ${placemark.subThoroughfare ?? 'N/A'}, ${placemark.administrativeArea ?? 'N/A'},${placemark.subAdministrativeArea ?? 'N/A'},${placemark.country ?? 'N/A'}';

                              MyplaceName = formattedAddress ?? '';
                            });

                            Future.delayed(Duration(seconds: 2), () {
                              // Your code to be executed after the delay
                              Navigator.of(context).pushReplacement(

                                  MaterialPageRoute(builder: (context) =>
                                      MapClassForOrder(request:
                                      RequestModel(
                                          Km:CorrectDist.toInt().toString() ,

                                          TargetPlaceName: controller.text.toString(),
                                          StartPlaceName :MyplaceName.toString() ,
                                          date: new DateTime.now().toString(),
                                          StartLat: MyPosition.latitude
                                              .toString(),
                                          StartLong: MyPosition.longitude
                                              .toString(),
                                          EndLat: SelectedLat,
                                          EndLong: SelectedLong,
                                          requestOwnerEmail: FirebaseAuth
                                              .instance.currentUser!
                                              .emailVerified.toString(),
                                          requestOwnerNumber: FirebaseAuth
                                              .instance.currentUser!.phoneNumber
                                              .toString(),
                                          Cash: FinalCash,
                                          Type: Type_ofTrans,
                                          diverEmail: "null",
                                          diverNumber: "null"


                                      ),
                                        polylines: polylines,


                                      ))
                              );
                            });
                          }

                          if(TargetAreaText =="" || Type_ofTrans=="" || TargetAreaText.isEmpty==true || Type_ofTrans.isEmpty==true ) {
                            setState(() {

                              ToastVisibilty=true;

                            });


                          }

                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/src/next.png'),
                              width: 100.w,
                              height: 100.h,
                            ),
                            Text(clicked? "انتظر":"التالي",
                              style: TextStyle(
                                  color: Colors.black ,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500
                              ),)
                          ],
                        ),
                      ),

                    ],

                    )

                    ),
                  Visibility(
                    visible: ToastVisibilty,
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 30.h,

                      child: Text("املأ باقي الطلبات",textAlign: TextAlign.center,),
                    ),
                  )



                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
