import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_manager/getx_demo/getx_router.dart';

class GetBuilderPage extends StatelessWidget {
  GetBuilderPage({Key? key}) : super(key: key);

  final controller = Get.put(_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(GetXRouter.getBuilder),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<_Controller>(
            builder: (controller) {
              print('rebuild A');
              return Text('A: ${controller.a}');
            },
            filter: (controller) => controller.a,
          ),
          TextButton(
              onPressed: () {
                controller.increaseA();
              },
              child: const Text('A +')),
          GetBuilder<_Controller>(
            builder: (controller) {
              print('rebuild B');

              return Text('B: ${controller.b}');
            },
            filter: (controller) => controller.b,
          ),
          TextButton(
              onPressed: () {
                controller.increaseB();
              },
              child: const Text('B +')),
        ],
      )),
    );
  }
}

class _Controller extends GetxController {
  var a = 0;

  var b = 0;

  void increaseA() {
    a += 1;
    update();
  }

  void increaseB() {
    b += 1;
    update();
  }
}
