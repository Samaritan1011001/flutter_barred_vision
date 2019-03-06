import 'dart:typed_data';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';

class BarCodeDetector extends ValueNotifier<Barcode> {
  BarCodeDetector._() : super(null);

  static CameraController _controller;
  static bool _isDetecting = false;

  static final BarCodeDetector instance = BarCodeDetector._();

  final BarcodeDetector detector = FirebaseVision.instance.barcodeDetector();

//  CameraController get controller => _controller;

  bool get barCodeDetected => (value?.rawValue?.isNotEmpty ?? false);
  String get barCodeValue => (value?.rawValue);

  detect(CameraController controller) async {
    _controller = controller;

    try {
      _controller.startImageStream((CameraImage image) {
        if (!_isDetecting) {
          _isDetecting = true;
          _runDetection(image);
        }
      });

    } on CameraException catch (e){
      print("error here => $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    suspend();
  }

  void suspend() {
    _isDetecting =false;
    _controller?.dispose();
    _controller = null;
    value = null;
  }

  void _runDetection(CameraImage image) async {
//    print("image -> ${image.toString()}");
    final int numBytes =
    image.planes.fold(0, (count, plane) => count += plane.bytes.length);
    final Uint8List allBytes = Uint8List(numBytes);

    int nextIndex = 0;
    for (int i = 0; i < image.planes.length; i++) {
      allBytes.setRange(nextIndex, nextIndex + image.planes[i].bytes.length,
          image.planes[i].bytes);
      nextIndex += image.planes[i].bytes.length;
    }

    try {
      final dynamic results =
      await detector.detectInImage(FirebaseVisionImage.fromBytes(
        allBytes,
        FirebaseVisionImageMetadata(
            rawFormat: image.format.raw,
            size: Size(image.width.toDouble(), image.height.toDouble()),
            rotation: ImageRotation.rotation270,
            planeData: image.planes
                .map((plane) => FirebaseVisionImagePlaneMetadata(
              bytesPerRow: plane.bytesPerRow,
              height: plane.height,
              width: plane.width,
            ))
                .toList()),
      ));

      if (results.isNotEmpty) {
        print("detected");
        value = results[0];
      }
    } catch (exception) {
      print(exception);
    } finally {
      _isDetecting = false;
    }
  }
}
