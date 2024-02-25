import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tager/useCases/googleSignin.dart';
class LoginPageClass extends StatefulWidget {
  const LoginPageClass({super.key});

  @override
  State<LoginPageClass> createState() => _LoginPageClassState();
}

class _LoginPageClassState extends State<LoginPageClass> {
  @override
  Widget build(BuildContext context) {

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
                    signInWithGoogle(context);


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
