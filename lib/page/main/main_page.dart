import 'package:dipay_web_view/model/activation.dart';
import 'package:dipay_web_view/model/base_callback.dart';
import 'package:dipay_web_view/page/main/main_controller.dart';
import 'package:dipay_web_view/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        init: MainController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Dipay Demo WebView'),
              ),
              body: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: controller.phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.phone),
                          hintText: "Masukkan nomor dipay kamu",
                          labelText: "Nomor Dipay"),
                    ),
                    ElevatedButton(
                      onPressed: controller.phoneNumberController.text.isEmpty
                          ? null
                          : () async {
                              var result = await Get.toNamed(AppRoutes.web, arguments: ["Aktivasi", "/activation?clientId=${controller.clientId}&phoneNumber=${controller.phoneNumberController.text}"]);
                              if(result != null){
                                var secretKey = (result as BaseCallback<Activation>).data?.secretKey;
                                if(secretKey != null){
                                  controller.setSecretKey(secretKey);
                                  Get.snackbar("JWT", secretKey, snackPosition: SnackPosition.BOTTOM);
                                }
                              }
                            },
                      child: const Text('Aktivasi'),
                    ),
                    ElevatedButton(
                      onPressed: controller.secretKey.isEmpty
                          ? null
                          : () async {
                        var result = await Get.toNamed(AppRoutes.web, arguments: ["Home", "?clientId=${controller.clientId}&secretKey=${controller.secretKey}&isNewUser=true"]);

                        if(result != null){
                          if(result["unlink"] == true){
                            controller.setSecretKey("");
                          }
                        }
                      },
                      child: const Text('Beranda'),
                    ),
                    ElevatedButton(
                      onPressed: controller.secretKey.isEmpty
                          ? null
                          : () {
                        Get.toNamed(AppRoutes.web, arguments: ["Pembayaran", "/payment?clientId=${controller.clientId}&secretKey=${controller.secretKey}&productCode=PROD01&transactionNumber=000001&amount=10000"]);
                      },
                      child: const Text('Pembayaran'),
                    ),
                  ],
                ),
              ));
        });
  }
}
