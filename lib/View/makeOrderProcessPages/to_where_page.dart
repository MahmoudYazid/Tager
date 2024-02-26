import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tager/View/home.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:tager/resourses/GoogleApiKey.dart';
import '../../Model/AutoCompleteResp.dart';

class ToWherePage extends StatefulWidget {
  const ToWherePage({Key? key}) : super(key: key);

  @override
  _ToWherePageState createState() => _ToWherePageState();
}

class _ToWherePageState extends State<ToWherePage> {
  Future<AutoCompleteResp?> recommendationData = Future.value(null);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<AutoCompleteResp?>(
      future:recommendationData ,
      builder: (context, snapshot) {
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
                        googleAPIKey: GoogleApikeyInst,
                        debounceTime: 400, // defaults to 600 ms
                        isLatLngRequired: true, // if you require the coordinates from the place details
                        getPlaceDetailWithLatLng: (prediction) {
                          // this method will return latlng with place detail
                          print("Coordinates: (${prediction.lat},${prediction.lng})");
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
                      Column(
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
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500
                            ),)
                        ],
                      ),
                      Column(
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
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500
                            ),)
                        ],
                      ),
                      Column(
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
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500
                            ),)
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/src/next.png'),
                            width: 100.w,
                            height: 100.h,
                          ),
                          Text("التالي",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500
                            ),)
                        ],
                      ),
                    ],

                    )

                    ),



                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
