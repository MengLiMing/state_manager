import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_manager/provider_demo/provider_router.dart';

class ProviderPage extends StatelessWidget {
  const ProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ProviderRouter.provider),
      ),
      body: Provider(
        create: (context) => 2,
        child: const _ProviderContainer(),
      ),
    );
  }
}

class _ProviderContainer extends StatelessWidget {
  const _ProviderContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<int>(builder: (context, value, _) {
        return Text(value.toString());
      }),
    );
  }
}
