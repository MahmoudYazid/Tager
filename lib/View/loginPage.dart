import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tager/useCases/googleSignin.dart';

import '../useCases/GetMyLocation.dart';
class LoginPageClass extends StatefulWidget {
  const LoginPageClass({super.key});

  @override
  State<LoginPageClass> createState() => _LoginPageClassState();
}

class _LoginPageClassState extends State<LoginPageClass> {
  @override
  Widget build(BuildContext context) {
    var dialogContext = context;

    return MaterialApp(
      home: Scaffold(
        body: Container(
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Data Handling Disclosure",style: TextStyle(color: Colors.black),),
                          content: Text("Your app handles location data to provide relevant " +
                              "" +
                              "features and improve user experience. We respect your privacy and ensure that your data is" +
                              " securely handled."+
                              "We use this only for gps activities that belongs to the purpose of app  "
                              ,style: TextStyle(color: Colors.black)),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                determinePosition(dialogContext).then((value) =>{
                                    signInWithGoogle(dialogContext)


                                }

                                );
                              },
                              child: Text("OK"),
                            ),
                            TextButton(
                              onPressed: () {
                                exit(0);
                              },
                              child: Text("no"),
                            )

                          ],
                        );
                      },
                    );



                  },
                  child: Image.network(
                      'http://pngimg.com/uploads/google/google_PNG19635.png',
                      width: 60.w,
                      height: 60.h,

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
