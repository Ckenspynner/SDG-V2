import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../login/logins.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    //const CountyDetails()
                    const Login()
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
          //=============================================================Web
          // Center(
          //   child: Image.network(
          //     "https://mspwarehouse.s3.amazonaws.com/bin.gif",
          //     height: 125.0,
          //     width: 125.0,
          //   ),
          // ),
          //============================================================Android
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
