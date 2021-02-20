import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:my_cities_time/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:image/image.dart' as img;
class BlocCamera {
  var cameras = BehaviorSubject<List<CameraDescription>>();
  var selectCamera = BehaviorSubject<bool>();
  var imagePath = BehaviorSubject<File>();
  var cameraOn = BehaviorSubject<int>();

  CameraController controllCamera;

  Future getCameras() async {
    await availableCameras().then((lista) {
      cameras.sink.add(lista);
    }).catchError((e) {
      print("ERROR CAMERA: $e");
    });
  }

  Future<String> takePicture() async {
    if (!controllCamera.value.isInitialized) {
      print("selected camera");
      return null;
    }

    if (controllCamera.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final xFile = await controllCamera.takePicture();
      // img.Image image = img.decodeImage(File(xFile.path).readAsBytesSync());
      // image=copyCrop(image,0,0,50,50);

// var f= File('example.png').writeAsBytesSync(img.encodePng(image));
//       final codec = await instantiateImageCodec(image.getBytes(format: img.Format.rgba));
//       final frameInfo = await codec.getNextFrame();
      //File f=File.fromRawPath(image.getBytes(format: img.Format.rgba));

      File croppedFile = await ImageCropper.cropImage(
          sourcePath: xFile.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: fontOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
      );

      return croppedFile.path;
    } on CameraException catch (e) {
      print(e);
      return null;
    }
  }
  img.Image copyCrop(img.Image src, int x, int y, int w, int h) {
    img.Image dst = img.Image(w, h, channels: src.channels, exif: src.exif,
        iccp: src.iccProfile);

    for (int yi = 0, sy = y; yi < h; ++yi, ++sy) {
      for (int xi = 0, sx = x; xi < w; ++xi, ++sx) {
        dst.setPixel(xi, yi, src.getPixel(sx, sy));
      }
    }

    return dst;
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void onTakePictureButtonPressed(context) {
    takePicture().then((String filePath) {
      imagePath.sink.add(File(filePath));
      print("afnan hassan");
      print(filePath);
      if (filePath== null)
        Navigator.pop(context,
            filePath);
      else {
        // widget
        //     .onFile(bloc.imagePath.value);
      }
    });
  }

  Future<Null> onNewCameraSelected(CameraDescription cameraDescription) async {
    selectCamera.sink.add(null);
    if (controllCamera != null) {
      await controllCamera.dispose();
    }
    controllCamera =
        CameraController(cameraDescription, ResolutionPreset.medium);
    controllCamera.addListener(() {
      if (controllCamera.value.hasError) selectCamera.sink.add(false);
    });

    await controllCamera.initialize().then((value) {
      selectCamera.sink.add(true);
    }).catchError((e) {
      debugPrint('####### ERROR ####### ');
      debugPrint(e);
      debugPrint('############## ');
    });

    return;
  }

  Future<Null> changeCamera() async {
    try {
      var list = cameras.value;

      debugPrint('LOGX: ${list.length}');
      if (list.length > 1) {
        var listCameraFront = list
            .where((val) => val.lensDirection == CameraLensDirection.front)
            .toList();

        var listCameraBack = list
            .where((val) => val.lensDirection == CameraLensDirection.back)
            .toList();

        if (controllCamera.description.lensDirection ==
            CameraLensDirection.back) {
          debugPrint('LOGX: Frontal selected');
          await onNewCameraSelected(listCameraFront[0]);
          cameraOn.sink.add(list.indexOf(listCameraFront[0]));
        } else {
          debugPrint('LOGX: Back selected');
          await onNewCameraSelected(listCameraBack[0]);
          cameraOn.sink.add(list.indexOf(listCameraBack[0]));
        }
      }
      return;
    } catch (e) {
      debugPrint('####### ERROR ####### ');
      debugPrint(e);
      debugPrint('############## ');
    }
  }

  void deletePhoto() {
    var dir = new Directory(imagePath.value.path);
    dir.deleteSync(recursive: true);
    imagePath.sink.add(null);
  }

  void dispose() {
    cameras.close();
    controllCamera.dispose();
    selectCamera.close();
    imagePath.close();
    cameraOn.close();
  }

  /* Future<Null> cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
      toolbarTitle: "Editar",
      toolbarColor: Colors.black,
      
      sourcePath: imagePath.value.path,
      ratioX: 1.0,
      ratioY: 1.0,
      maxWidth: 512,
      maxHeight: 512,
    );

    if (croppedFile != null) imagePath.sink.add(croppedFile);
  }*/
}
