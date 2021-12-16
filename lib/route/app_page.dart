import 'package:dipay_web_view/page/main/main_page.dart';
import 'package:dipay_web_view/page/webview/webview_page.dart';
import 'package:dipay_web_view/route/app_route.dart';
import 'package:get/get.dart';

List<GetPage> appPages = [
  GetPage(name: AppRoutes.main, page: () => MainPage()),
  GetPage(name: AppRoutes.web, page: () => WebViewPage()),
];
