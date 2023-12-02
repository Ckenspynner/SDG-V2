import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sdg/main.dart';
import 'package:sdg/src/screens/county/countydetails.dart';

import '../login/logins.dart';

class SplashscreenLoggedIn extends StatefulWidget {
  const SplashscreenLoggedIn({super.key});

  @override
  _SplashscreenLoggedInState createState() => _SplashscreenLoggedInState();
}
class _SplashscreenLoggedInState extends State<SplashscreenLoggedIn> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    const CountyDetails(email: '',)
                    //const Login()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        //color: darkBlue,
        //child:FlutterLogo(size:MediaQuery.of(context).size.height)
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Center(
          //   child: LoadingAnimationWidget.dotsTriangle(
          //     size: 70,
          //     color: Colors.blue,
          //   ),
          // ),
          //==========================================================web
          // Center(
          //   child: Image.network(
          //     "https://mspwarehouse.s3.amazonaws.com/bin.gif",
          //     height: 125.0,
          //     width: 125.0,
          //   ),
          // ),
          //==========================================================Android
          Center(
            child: Image.asset(
              "assets/itemclasses/bin.gif",
              height: 125.0,
              width: 125.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const DefaultTextStyle(
            style: TextStyle(decoration: TextDecoration.none),
            child: Text(
              'Marine Litter\nSDG',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'ProximaNova',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
