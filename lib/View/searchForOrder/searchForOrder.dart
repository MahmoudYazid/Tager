import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tager/View/home.dart';
import 'package:tager/View/searchForOrder/result.dart';

class seachForOrder extends StatefulWidget {
  const seachForOrder({super.key});

  @override
  State<seachForOrder> createState() => _seachForOrderState();
}

class _seachForOrderState extends State<seachForOrder> {
  String Type_ofTrans = "";
  String SearchWord = "";
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
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
                child:TextField(

                  onChanged: (e){
                    setState(() {
                      SearchWord=e;
                    });
                  },


                  decoration: const InputDecoration(

                    hintText:"الي",
                    labelStyle: TextStyle(color: Colors.black),

                    border: OutlineInputBorder(),


                  ),
                  textAlign: TextAlign.center,

                ),
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
                      Visibility(
                        visible: Type_ofTrans.isNotEmpty && SearchWord.isNotEmpty? true:false,
                        child: TextButton(
                          onPressed: (){
                            Navigator.of(context).pushReplacement(

                                MaterialPageRoute(builder: (context)=> Result(place: SearchWord, TypeChoosen:Type_ofTrans))
                            );


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
                              Text("التالي",
                                style: TextStyle(
                                    color: Colors.black ,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500
                                ),)
                            ],
                          ),
                        ),
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
}
