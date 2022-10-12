// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_manager/riverpod_demo/riverpod_router.dart';

class ProviderPage extends StatefulWidget {
  const ProviderPage({Key? key}) : super(key: key);

  @override
  State<ProviderPage> createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(RiverpodRouter.provider),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Row(
              children: [
                const Expanded(child: Text('数据提供')),
                Consumer(
                  builder: (context, ref, child) {
                    return Text(ref.watch(_counterProvider).toString());
                  },
                )
              ],
            ),
            Consumer(builder: (context, ref, _) {
              return TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 11,
                minLines: 1,
                maxLines: 1,
                decoration:
                    const InputDecoration(counterText: '', hintText: '请输入手机号'),
                onChanged: (value) {
                  ref.read(_userInfoProvider.notifier).changePhone(value);
                },
              );
            }),
            Consumer(builder: (context, ref, _) {
              return TextFormField(
                minLines: 1,
                maxLines: 1,
                obscureText: true,
                decoration:
                    const InputDecoration(counterText: '', hintText: '请输入密码'),
                onChanged: (value) {
                  ref.read(_userInfoProvider.notifier).changePwd(value);
                },
              );
            }),
            Consumer(builder: (context, ref, _) {
              final isComplete = ref.watch(_isComplete);
              return TextButton(
                  onPressed: isComplete ? () {} : null,
                  child: const Text('登录'));
            }),
          ]),
        ),
      ),
    );
  }
}

final _counterProvider = Provider<int>((ref) => 1);

final _userInfoProvider = StateNotifierProvider<_UserInfoNotifier, _UserInfo>(
    (ref) => _UserInfoNotifier());

final _isComplete = Provider<bool>((ref) {
  final info = ref.watch(_userInfoProvider);
  return info.phone.length == 11 && info.pwd.length >= 8;
});

class _UserInfoNotifier extends StateNotifier<_UserInfo> {
  _UserInfoNotifier() : super(_UserInfo());

  void changePhone(String? phone) {
    state = state.copyWith(phone: phone);
  }

  void changePwd(String? pwd) {
    state = state.copyWith(pwd: pwd);
  }

  bool get isComplete => state.phone.length == 11 && state.pwd.length > 8;
}

class _UserInfo {
  String phone;
  String pwd;
  _UserInfo({
    this.phone = '',
    this.pwd = '',
  });

  _UserInfo copyWith({
    String? phone,
    String? pwd,
  }) {
    return _UserInfo(
      phone: phone ?? this.phone,
      pwd: pwd ?? this.pwd,
    );
  }

  @override
  bool operator ==(covariant _UserInfo other) {
    if (identical(this, other)) return true;

    return other.phone == phone && other.pwd == pwd;
  }

  @override
  int get hashCode => phone.hashCode ^ pwd.hashCode;
}
