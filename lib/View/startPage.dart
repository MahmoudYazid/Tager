import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tager/View/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
// Required by Firebase plugins
  runApp(const startPage());
}
class startPage extends StatefulWidget {
  const startPage({super.key});

  @override
  State<startPage> createState() => _startPageState();
}

class _startPageState extends State<startPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: Builder(
            builder: (context) {
              Future.delayed(Duration(seconds: 3),(){

              Navigator.of(context).pushReplacement(

                MaterialPageRoute(builder: (context)=> LoginPageClass())
              );
              });

              return Scaffold(

                body: Container(
                  color: Colors.white,
                  child: Center(
                    child: Image(
                        image: AssetImage('assets/src/logowithoutbg.png')
                    ),

                  ),
                ),
              );
            }
          ),
        );
      },

    );
  }


  }

