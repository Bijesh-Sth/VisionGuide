import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';

class ScanController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initCamera();
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  late CameraController cameraController;
  late List<CameraDescription> cameras;

  var isCameraReady = false.obs;

  initCamera() async {
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();
      cameraController = CameraController(cameras[0], ResolutionPreset.max);
      await cameraController.initialize();
      isCameraReady(true);
      update();
    } else {
      Get.snackbar(
        'Camera Permission',
        'Please allow camera permission to use this app',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(20),
        borderRadius: 10,
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.camera_alt),
      );
    }
  }
}
