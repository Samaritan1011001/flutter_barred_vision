import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_barred_vision/flutter_barred_vision.dart';
import 'package:flutter_barred_vision/utils/screenRatio.dart';
import 'package:flutter_barred_vision_example/barcodeCamera.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  void initState() {
    super.initState();

//    initPlatformState();
  }



  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        body: Center(
          child: RaisedButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BarcodeCamera()));
          },child: Text("Click to scan"),),
        ),
      );
  }
}
