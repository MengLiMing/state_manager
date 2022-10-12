import 'package:flutter/material.dart';
import 'package:flutter_table_list_view/flutter_table_list_view.dart';
import 'package:get/route_manager.dart';
import 'package:state_manager/getx_demo/getx_router.dart';
import 'package:state_manager/provider_demo/provider_router.dart';
import 'package:state_manager/riverpod_demo/riverpod_router.dart';

void main() => runApp(const MainApp());

typedef RouterMap = Map<String, WidgetBuilder>;
final Map<String, RouterMap> routers = {
  ProviderRouter.title: ProviderRouter.routers,
  RiverpodRouter.title: RiverpodRouter.routers,
  GetXRouter.title: GetXRouter.routers,
};

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '状态管理',
      home: const HomePage(),
      routes: routers.values.reduce(
        (value, element) => {
          ...value,
          ...element,
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterTableViewController controller = FlutterTableViewController();

  @override
  Widget build(BuildContext context) {
    final headers = routers.keys;
    return Scaffold(
      appBar: AppBar(
        title: const Text('状态管理'),
      ),
      body: FlutterTableView(
        physics: const AlwaysScrollableScrollPhysics(),
        autoLoad: true,
        sectionCount: () => headers.length,
        rowCount: (section) {
          final key = headers.elementAt(section);
          return routers[key]!.length;
        },
        controller: controller,
        itemBuilder: (context, indexPath) {
          final key = headers.elementAt(indexPath.section);
          final singleRouters = routers[key]!;
          final rowKey = singleRouters.keys.elementAt(indexPath.row);
          return ListTile(
            title: Text(rowKey),
            onTap: () {
              Navigator.of(context).pushNamed(rowKey);
            },
          );
        },
        headerBuilder: (context, sectionIndex, isHover) {
          final key = headers.elementAt(sectionIndex);
          return Container(
            padding: const EdgeInsets.only(left: 10),
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(key),
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 0.5,
                  child: ColoredBox(color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
