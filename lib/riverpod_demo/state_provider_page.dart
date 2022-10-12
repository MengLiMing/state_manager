import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_manager/riverpod_demo/riverpod_router.dart';

class StateProviderPage extends StatelessWidget {
  const StateProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(RiverpodRouter.stateProvider),
      ),
      body: const Center(
        child: _Counter(),
      ),
    ));
  }
}

class _Counter extends ConsumerWidget {
  const _Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Consumer(builder: (context, ref, _) {
          return Text(ref.watch(_counter).toString());
        }),
        TextButton(
            onPressed: () => ref.read(_counter.state).state += 1,
            child: const Text('+')),
        TextButton(
            onPressed: () => ref.refresh(_counter), child: const Text('重置'))
      ],
    );
  }
}

final _counter = StateProvider((ref) => 0);
