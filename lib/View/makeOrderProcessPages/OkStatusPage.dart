import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tager/View/home.dart';

class OkStatus extends StatefulWidget {
  const OkStatus({super.key});

  @override
  State<OkStatus> createState() => _OkStatusState();
}

class _OkStatusState extends State<OkStatus> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image:AssetImage( "assets/src/done.png"),
              width: 100.w,
                height: 100.h,

              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pushReplacement(

                      MaterialPageRoute(builder: (context)=> Home())
                  );
                },
                  child: Text("الصفحه الرئيسيه",
                    style: TextStyle(
                    fontWeight: FontWeight.w400,
                      fontSize: 20.sp

                  ),
                  ),
              )

            ],
          ),

        ),
      ),
    );
  }
}
