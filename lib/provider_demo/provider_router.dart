import 'package:flutter/material.dart';
import 'package:state_manager/provider_demo/change_notifier_provider_page.dart';
import 'package:state_manager/provider_demo/change_notifier_proxy_provider_page.dart';
import 'package:state_manager/provider_demo/future_provider_page.dart';
import 'package:state_manager/provider_demo/provider_page.dart';
import 'package:state_manager/provider_demo/proxy_provider_page.dart';
import 'package:state_manager/provider_demo/stream_provider_page.dart';

class ProviderRouter {
  static const String title = 'Provider';

  static const String provider = 'Provider';
  static const String changeNotifierProvider = 'ChangeNotifierProvider';
  static const String futuerProvider = 'FutureProvider';
  static const String streamProvider = 'StreamProvider';
  static const String proxyProvider = 'ProxyProvider';
  static const String changeNotifierProxyProvider =
      'ChangeNotifierProxyProvider';

  static Map<String, WidgetBuilder> routers = {
    provider: (context) => const ProviderPage(),
    changeNotifierProvider: (context) => const ChangeNotifierProviderPage(),
    futuerProvider: (context) => const FutureProviderPage(),
    streamProvider: (context) => const StreamProviderPage(),
    proxyProvider: (context) => const ProxyProviderPage(),
    changeNotifierProxyProvider: (context) =>
        const ChangeNotifierProxyProviderPage(),
  };
}
