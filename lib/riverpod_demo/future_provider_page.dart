import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_manager/riverpod_demo/riverpod_router.dart';

class FutureProviderPage extends StatelessWidget {
  const FutureProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(RiverpodRouter.futureProvider),
        ),
        body: const Center(
          child: _Counter(),
        ),
      ),
    );
  }
}

class _Counter extends ConsumerWidget {
  const _Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Consumer(builder: (context, ref, _) {
          return ref.watch(request).map(data: (value) {
            if (value.isLoading) return const CircularProgressIndicator();
            return Text('数据 ${value.value}');
          }, error: (error) {
            return Text(error.error.toString());
          }, loading: (_) {
            return const CircularProgressIndicator();
          });
        }),
        TextButton(
          onPressed: () {
            ref.refresh(request);
          },
          child: const Text('刷新'),
        ),
        Consumer(builder: (context, ref, _) {
          return ref.watch(appConfig).when(data: (_) {
            print(DateTime.now());
            return Text('程序初始化完成');
          }, error: (_, __) {
            return Text('错误');
          }, loading: () {
            print(DateTime.now());
            return Text('loading');
          });
        }),
      ],
    );
  }
}

final request = FutureProvider.autoDispose<int>((ref) async {
  ref.onDispose(() {
    /// 可以在此处取消网络请求
    print('dispose');
  });
  await Future.delayed(const Duration(seconds: 2));
  return Random().nextInt(1000);
});

final sharePreference = FutureProvider<void>((ref) async {
  /// 可以保存起来，封装存储 ，或者直接返回，使用此provider
  await SharedPreferences.getInstance();
});

final loadConfig = FutureProvider<void>((ref) async {
  /// 获取一些本地存储的数据等
  await Future.delayed(const Duration(seconds: 2));
  ;
});

final otherFuture = FutureProvider<void>((ref) async {
  await Future.delayed(const Duration(seconds: 4));
});

final appConfig = FutureProvider<void>((ref) async {
  await Future.wait([
    ref.watch(sharePreference.future),
    ref.watch(loadConfig.future),
    ref.watch(otherFuture.future),
  ]);
});
