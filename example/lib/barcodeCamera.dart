import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_barred_vision/flutter_barred_vision.dart';
import 'package:flutter_barred_vision/utils/screenRatio.dart';


class BarcodeCamera extends StatefulWidget {
  @override
  BarcodeCameraState createState() => BarcodeCameraState();
}

class BarcodeCameraState extends State<BarcodeCamera> {


  double boxHeight ;
  double boxWidth ;

  double focusEdgeWidth ;
  double focusEdgeHeight ;
  @override
  void initState() {
    super.initState();

//    WidgetsBinding.instance.addPostFrameCallback((_) async {
//      boxHeight = 250 * ScreenRatio.heightRatio;
//      boxWidth = 275 * ScreenRatio.widthRatio;
//
//      focusEdgeWidth = 40 * ScreenRatio.widthRatio;
//      focusEdgeHeight = 40 * ScreenRatio.widthRatio;    });
//    initPlatformState();
  }



  @override
  Widget build(BuildContext context) {
    ScreenRatio.setScreenRatio(
        currentScreenHeight: MediaQuery.of(context).size.height,
        currentScreenWidth: MediaQuery.of(context).size.width);
    boxHeight = 250 * ScreenRatio.heightRatio;
    boxWidth = 275 * ScreenRatio.widthRatio;

    focusEdgeWidth = 40 * ScreenRatio.widthRatio;
    focusEdgeHeight = 40 * ScreenRatio.widthRatio;

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            FlutterBarredVision(
              onBarcodeDetected: (barcode){
                print("barcode -> ${barcode}");
              },
            ),

//        Positioned.fill(
//          child: Image.network(
//            "https://openclipart.org/image/2400px/svg_to_png/228343/Colorful-Plus-Pattern-Wallpaper.png",
//            fit: BoxFit.cover,
//          ),
//        ),

            Align(
              alignment:AlignmentDirectional.centerStart,
              child: ClipPath(
//            clipBehavior: Clip.hardEdge,
                clipper: ScanAreaClipper(boxHeight: boxHeight,boxWidth: boxWidth),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),

            //Solution 1 for barcode UI
//          new Container(
//            width: MediaQuery.of(context).size.width,
//            height: MediaQuery.of(context).size.height,
//            decoration: new BoxDecoration(
////                  color: Colors.grey.shade200.withOpacity(0.5),
//              border: Border(
//                top: BorderSide(
//                  width: 208 * ScreenRatio.heightRatio + 4,
////                    color: Color.fromRGBO(255, 255, 255, 0.7),
//                  color: Color.fromRGBO(255, 255, 255, 0.7),
//                ),
//                left: BorderSide(
//                    width: 80 * ScreenRatio.widthRatio - 4,
//                    color: Color.fromRGBO(255, 255, 255, 0.7)),
//                right: BorderSide(
//                    width: 80 * ScreenRatio.widthRatio - 4,
//                    color: Color.fromRGBO(255, 255, 255, 0.7)),
//                bottom: BorderSide(
//                    width: 208 * ScreenRatio.heightRatio + 4,
//                    color: Color.fromRGBO(255, 255, 255, 0.7)),
//              ),
//            ),
//          ),
//
//          Positioned(
//            top: 20.0,
//            left: 20.0,
//            child: IconButton(
//              color: Colors.white,
//              iconSize: 40.0,
//              icon: Icon(_isOn ? Icons.flash_off : Icons.flash_on),
//              onPressed: () {
//                _turnFlash();
//              },
//            ),
//          ),

//          Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
            Positioned(
              left:(MediaQuery.of(context).size.width - boxWidth)/2,
              top: (MediaQuery.of(context).size.height - boxHeight)/2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  container(),
                  Padding(
                    padding: EdgeInsets.only(left: boxWidth-80),
                  ),
                  RotatedBox(
                    quarterTurns: 1,
                    child: container(),
                  ),
                ],
              ),
            ),
//              Padding(
//                padding: EdgeInsets.only(top: 135.0),
//              ),
            Positioned(
              left: (MediaQuery.of(context).size.width - boxWidth)/2,
              top: ((MediaQuery.of(context).size.height - boxHeight)/2) + boxHeight - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RotatedBox(
                    quarterTurns: 3,
                    child: container(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: boxWidth-80),
                  ),
                  RotatedBox(
                    quarterTurns: 2,
                    child: container(),
                  ),
                ],
              ),
            ),
//              SizedBox(
//                height: 64 * ScreenRatio.heightRatio,
//              ),
            Positioned(
//            left: MediaQuery.of(context).size.width/2,
              top: (MediaQuery.of(context).size.height/2) + (boxHeight/2),
              child: Padding(
                padding:  EdgeInsets.only(top:64 * ScreenRatio.heightRatio),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 8,right: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Text(
                        "Position QR code or bar code",
                        style: TextStyle(
                          fontSize: 16 * ScreenRatio.heightRatio,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8,right: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Text(
                        "in this frame to scan automatically",
                        style: TextStyle(
                          fontSize: 16 * ScreenRatio.heightRatio,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 32,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
//                controller.dispose();
//                reader.dispose();
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.clear,color: Colors.black,),
              ),
            ),

          ],
        ),
      );
  }
}
Widget container() {
  return Container(
      width: 40 ,
      height: 40 ,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 4.0, color: Colors.white),
          left: BorderSide(width: 4.0, color: Colors.white),
          right: BorderSide(width: 4.0, color: Colors.transparent),
          bottom: BorderSide(width: 4.0, color: Colors.transparent),
        ),
      ));
}

class ScanAreaClipper extends CustomClipper<Path> {
  var rect = Offset.zero;

  var boxWidth = 275.0;
  var boxHeight = 275.0;

  var positionFromLeft ;
  var positionFromTop ;

  ScanAreaClipper({this.boxHeight,this.boxWidth});
  @override
  Path getClip(Size size) {
    positionFromLeft = (size.width - boxWidth)/2;
    positionFromTop = (size.height - boxHeight)/2;
    return Path.combine(
        PathOperation.difference,
        Path()..addRect(Offset.zero & size),
        Path()
          ..addRect(Rect.fromLTWH(positionFromLeft,
              positionFromTop, boxWidth, boxHeight)));
  }

  @override
  bool shouldReclip(ScanAreaClipper old) => rect != old.rect;
}