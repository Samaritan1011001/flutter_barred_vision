


import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_barred_vision/barcodeDetector.dart';
//import 'package:flutter_barred_vision/utils/screenRatio.dart';


typedef onBarcodeDetectedCallback = Function(String);


class FlutterBarredVision extends StatefulWidget {
  CameraController controller;

  onBarcodeDetectedCallback onBarcodeDetected;


  FlutterBarredVision({this.controller,this.onBarcodeDetected});
  @override
  FlutterBarredVisionState createState() {
    return new FlutterBarredVisionState();
  }
}

class FlutterBarredVisionState extends State<FlutterBarredVision> {
  bool barCodeDetected = false;
  BarCodeDetector reader;

  @override
  initState() {
    barCodeDetected = false;
    initPlatformState();
    super.initState();
  }

  @override
  void dispose() {
    widget.controller?.stopImageStream();
    super.dispose();
  }


//  onBarcodeObtained(context,barcode)async{
//
//
//  }

  initPlatformState() async {
    if (widget.controller == null||reader == null) {
      final List<CameraDescription> cameras = await availableCameras();

      CameraDescription backCamera;
      for (CameraDescription camera in cameras) {
        if (camera.lensDirection == CameraLensDirection.back) {
          backCamera = camera;
          break;
        }
      }

      if (backCamera == null) throw ArgumentError("No back camera found.");
      reader = BarCodeDetector.instance;


      widget.controller = new CameraController(backCamera, ResolutionPreset.medium);

      try {
        await widget.controller.initialize();
      }on CameraException catch(_){
//        await showCameraDialog();
//        Navigator.of(context).pop();
        print("camera e ");
      }



    if (widget.controller.value.isInitialized) {
      print("initialised");

      reader.detect(widget.controller);
      reader.addListener(() async {
        if (reader.barCodeDetected) {
          if (!barCodeDetected) {
            barCodeDetected = true;
            widget.onBarcodeDetected(reader.barCodeValue);
          }
        }
      });

      setState(() {

      });
    }
    }else{
      if (widget.controller.value.isInitialized) {
        print("initialised");

        reader.detect(widget.controller);
        reader.addListener(() async {
          if (reader.barCodeDetected) {
            if (!barCodeDetected) {
              barCodeDetected = true;
              widget.onBarcodeDetected(reader.barCodeValue);
            }
          }
        });
        setState(() {

        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    print("widget.controller => ${widget.controller}");

    return widget.controller != null
              ? Transform.scale(
            scale: widget.controller.value.aspectRatio / deviceRatio,
            child: Center(
              child: AspectRatio(
                aspectRatio: widget.controller.value.aspectRatio,
                child: CameraPreview(widget.controller),
              ),
            ),
          ) : Container(width: 0,height: 0,);
  }



}


