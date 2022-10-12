import 'package:flutter/material.dart';
import 'package:state_manager/riverpod_demo/future_provider_page.dart';
import 'package:state_manager/riverpod_demo/provider_page.dart';
import 'package:state_manager/riverpod_demo/state_provider_page.dart';

class RiverpodRouter {
  static const String title = 'Riverpod';

  static const String provider = 'Provider';
  static const String stateProvider = 'StateProvider';
  static const String futureProvider = 'FutureProvider';

  static Map<String, WidgetBuilder> routers = {
    provider: (context) => const ProviderPage(),
    stateProvider: (context) => const StateProviderPage(),
    futureProvider: (context) => const FutureProviderPage(),
  };
}
