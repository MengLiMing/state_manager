import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_manager/provider_demo/provider_router.dart';

class FutureProviderPage extends StatelessWidget {
  const FutureProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ProviderRouter.futuerProvider),
      ),
      body: FutureProvider.value(
        value: Future.delayed(
            const Duration(seconds: 2), () => _State()..loadCompleted()),
        initialData: _State(),
        child: Consumer<_State>(builder: (_, value, __) {
          Widget container;
          if (value.isLoading) {
            container = const CircularProgressIndicator();
          } else {
            container = const Text('加载完成');
          }
          return Center(child: container);
        }),
      ),
    );
  }
}

class _State {
  bool isLoading = true;

  void loadCompleted() {
    isLoading = false;
  }
}
