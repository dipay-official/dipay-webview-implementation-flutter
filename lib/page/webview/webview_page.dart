import 'dart:convert';

import 'package:dipay_web_view/model/activation.dart';
import 'package:dipay_web_view/model/base_callback.dart';
import 'package:dipay_web_view/model/payment.dart';
import 'package:dipay_web_view/page/webview/webview_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GetBuilder<WebViewController>(
        init: WebViewController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              bool canGoBack = await controller.webViewController?.canGoBack() ?? false;
              if(canGoBack){
                controller.webViewController?.goBack();
                return false;
              } else {
                return true;
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(controller.title),
              ),
              body: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(controller.url),
                ),
                initialOptions: controller.options,
                pullToRefreshController: controller.pullToRefreshController,
                onWebViewCreated: (webController) {
                  controller.webViewController = webController;
                  controller.webViewController?.addJavaScriptHandler(
                      handlerName: "ActivationHandler",
                      callback: (args) {
                          var responseCallback =
                              BaseCallback<Activation>.fromJson(
                                  jsonDecode(args.first), (json) => Activation.fromJson(json as Map<String, dynamic>));
                          Get.back(result: responseCallback, closeOverlays: true);
                      });

                  controller.webViewController?.addJavaScriptHandler(
                      handlerName: "UnlinkAccount",
                      callback: (args) {

                        var responseCallback =
                        BaseCallback<dynamic>.fromJson(
                            jsonDecode(args.first), (json) => null);
                        if(responseCallback.code == "00"){
                          Get.back(result: {
                            "unlink": true
                          });
                        }
                      });

                  controller.webViewController?.addJavaScriptHandler(
                      handlerName: "CloseWebView",
                      callback: (args) {

                        var responseCallback =
                        BaseCallback<dynamic>.fromJson(
                            jsonDecode(args.first), (json) => null);
                        if(responseCallback.code == "00"){
                          Get.back();
                        }
                      });

                  controller.webViewController?.addJavaScriptHandler(
                      handlerName: "CloseWebView",
                      callback: (args) {

                        var responseCallback =
                        BaseCallback<dynamic>.fromJson(
                            jsonDecode(args.first), (json) => null);
                        if(responseCallback.code == "00"){
                          Get.back();
                        }
                      });

                  controller.webViewController?.addJavaScriptHandler(
                      handlerName: "Payment",
                      callback: (args) {
                        var responseCallback =
                        BaseCallback<Payment>.fromJson(
                            jsonDecode(args.first), (json) => Payment.fromJson(json as Map<String, dynamic>));
                        if(responseCallback.code == "00"){
                          Get.snackbar("Pembayaran", "Pembayaran Berhasil\n${responseCallback.data.toString()}");
                        }
                      });
                },
                onLoadStart: (webController, url) {
                  print(url);
                },
                androidOnPermissionRequest:
                    (webController, origin, resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                shouldOverrideUrlLoading:
                    (webController, navigationAction) async {
                  var uri = navigationAction.request.url;
                  if (![
                    "http",
                    "https",
                    "file",
                    "chrome",
                    "data",
                    "javascript",
                    "about"
                  ].contains(uri?.scheme)) {
                    if (await canLaunch(controller.url)) {
                      // Launch the App
                      await launch(
                        controller.url,
                      );
                      // and cancel the request
                      return NavigationActionPolicy.CANCEL;
                    }
                  }

                  return NavigationActionPolicy.ALLOW;
                },
                onLoadStop: (webController, url) async {
                  controller.pullToRefreshController.endRefreshing();
                  await controller.webViewController
                      ?.injectJavascriptFileFromAsset(
                          assetFilePath: "assets/js/dipaycallback.js");
                },
                onLoadError: (webController, url, code, message) async {
                  controller.pullToRefreshController.endRefreshing();
                },
                onProgressChanged: (webController, progress) {
                  if (progress == 100) {
                    controller.pullToRefreshController.endRefreshing();
                  }
                },
                onUpdateVisitedHistory: (webController, url, androidIsReload) {},
                onConsoleMessage: (webController, consoleMessage) {},
              ),
            ),
          );
        });
  }
}
