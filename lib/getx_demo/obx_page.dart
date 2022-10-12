import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:state_manager/getx_demo/getx_router.dart';

class ObxPage extends StatelessWidget {
  ObxPage({Key? key}) : super(key: key);

  final _count = 0.obs;

  @override
  Widget build(BuildContext context) {
    GetStream;
    return Scaffold(
      appBar: AppBar(
        title: const Text(GetXRouter.obx),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => Text(_count.value.toString())),
          TextButton(
            onPressed: () {
              _count.value += 1;
            },
            child: const Text('+'),
          )
        ],
      )),
    );
  }
}
