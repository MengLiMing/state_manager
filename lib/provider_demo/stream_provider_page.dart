import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_manager/provider_demo/provider_router.dart';

class StreamProviderPage extends StatelessWidget {
  const StreamProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ProviderRouter.streamProvider),
      ),
      body: StreamProvider<int>(
        create: (_) {
          return Stream.periodic(const Duration(seconds: 1), (value) {
            return value;
          });
        },
        initialData: 0,
        builder: (context, __) {
          return Center(
            child: Text(context.watch<int>().toString()),
          );
        },
      ),
    );
  }
}
