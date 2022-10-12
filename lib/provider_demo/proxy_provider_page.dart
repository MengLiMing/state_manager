// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProxyProviderPage extends StatelessWidget {
  const ProxyProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _Counter()),
        ChangeNotifierProxyProvider<_Counter, _Logic>(
          create: (_) => _Logic(number: 0),
          update: (context, value, _) {
            return _Logic(number: value.count);
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('data')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<_Counter>(
                  builder: (_, value, __) => Text(value.count.toString())),
              Consumer<_Logic>(builder: (_, value, __) => Text(value.desc)),
              Builder(builder: (context) {
                return TextButton(
                  onPressed: () {
                    context.read<_Counter>().increase();
                  },
                  child: const Text('+'),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class _Counter extends ChangeNotifier {
  int count = 0;

  void increase() {
    count += 1;
    notifyListeners();
  }
}

class _Logic extends ChangeNotifier {
  int number;

  _Logic({
    required this.number,
  });

  String get desc => number.isEven ? "偶数" : "奇数";
}
