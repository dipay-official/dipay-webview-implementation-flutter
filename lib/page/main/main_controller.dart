import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  late TextEditingController phoneNumberController;
  String secretKey = "";
  String clientId = "DOCTOR_MIGRANT";

  @override
  void onInit() {
    phoneNumberController = TextEditingController();
    phoneNumberController.addListener(() {
      update();
    });
    super.onInit();
  }

  @override
  void onClose() {
    phoneNumberController.dispose();
    super.onClose();
  }

  void setSecretKey(String value) {
    secretKey = value;
    update();
  }
}
