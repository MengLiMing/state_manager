// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_manager/provider_demo/provider_router.dart';

class ChangeNotifierProviderPage extends StatelessWidget {
  const ChangeNotifierProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ProviderRouter.changeNotifierProvider),
      ),
      body: ChangeNotifierProvider(
        create: (context) => _State(), // 提供状态
        child: const Center(child: _CounterContainer()),
      ),
    );
  }
}

class _CounterContainer extends StatelessWidget {
  const _CounterContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _state = context.read<_State>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 如果有多个属性值更新，只想在一个值改变时刷新
            Selector<_State, int>(
              builder: (context, value, _) {
                print('text - rebuild');
                return Text(value.toString());
              },
              selector: (_, value) => value.count,
            ),
            TextButton(
              onPressed: _state.increase,
              child: const Text('+'),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 对比Selector
            Consumer<_State>(builder: (context, value, _) {
              print('switch - rebuild');
              return Switch(
                value: value.isOpen,
                onChanged: (_) {},
              );
            }),
            TextButton(
              onPressed: _state.change,
              child: const Text('打开/关闭'),
            ),
          ],
        )
      ],
    );
  }
}

class _State extends ChangeNotifier {
  int count = 0;

  bool isOpen = false;

  void increase() {
    count += 1;
    notifyListeners();
  }

  void change() {
    isOpen = !isOpen;
    notifyListeners();
  }
}
