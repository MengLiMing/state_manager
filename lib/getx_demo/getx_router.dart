import 'package:flutter/material.dart';
import 'package:state_manager/getx_demo/get_builder_page.dart';
import 'package:state_manager/getx_demo/obx_page.dart';

class GetXRouter {
  static const String title = 'GetX';

  static const String obx = 'Obx';
  static const String getBuilder = 'GetBuilder';

  static Map<String, WidgetBuilder> routers = {
    obx: (context) => ObxPage(),
    getBuilder: (context) => GetBuilderPage(),
  };
}
