import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tager/View/Activities/Activities.dart';
import 'package:tager/View/makeOrderProcessPages/to_where_page.dart';
import 'package:tager/View/searchForOrder/searchForOrder.dart';
import 'package:tager/View/trackGoodsAfterAccept/Track.dart';

import '../useCases/GetActiveRequestOfUser.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      home: Scaffold(

        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                    image: AssetImage('assets/src/logowithoutbg.png')
                ),

                TextButton(
                  onPressed: (){

                    Navigator.of(context).pushReplacement(

                        MaterialPageRoute(builder: (context)=> ToWherePage())
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                          image: AssetImage('assets/src/makeorder.png'),
                        width: 50.w,
                        height: 50.h,
                      ),
                      Text("عمل طلب",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                ),
                SizedBox(height: 10.h,)
              ,TextButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(

                        MaterialPageRoute(builder: (context)=> seachForOrder())
                    );
                  },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/src/search.png'),
                        width: 50.w,
                        height: 50.h,
                      ),
                      Text("البحث عن طلب",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500
                      ),
                      )
                    ],
                  ),
              ),
                SizedBox(height: 10.h,)
                ,TextButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(

                        MaterialPageRoute(builder: (context)=> Activities())
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/src/oldorders.png'),
                        width: 50.w,
                        height: 50.h,
                      ),
                      Text("السجل",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
