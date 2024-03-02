import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tager/View/home.dart';
import 'package:tager/View/trackGoodsAfterAccept/Track.dart';

import '../../useCases/GetActiveRequestOfUser.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();

    // Call the method to check the active request when the widget initializes
    checkActiveRequest();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> checkActiveRequest() async {
    // Wait for the result of GetActiveRequestOfUserSignal_f()
    var res = await GetActiveRequestOfUserSignal_f();

    // Based on the result, navigate to the appropriate screen
    if (res) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Track()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Return the rotating icon while waiting for the navigation to happen
    return RotationTransition(
      turns: _controller,
      child: Icon(Icons.refresh), // You can replace this with any icon you want
    );
  }
}
