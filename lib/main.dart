import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_vault/view/res/strings_utils.dart';
import 'package:gallery_vault/view/utils/net_conectivity.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/utils/app_binding.dart';
import 'package:gallery_vault/view/utils/my_behavior.dart';
import 'package:gallery_vault/view/utils/navigation_utils/routes.dart';
import 'package:gallery_vault/view/widgets/exit_popup.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'controller/functions/new_playlist_class.dart';
import 'controller/provider/gallery_data_provider.dart';
import 'controller/provider/preview_page_provider.dart';

Future<void> main() async {
  /// hive
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(PlaylistAdapter().typeId)) {
    Hive.registerAdapter(PlaylistAdapter());
  }

  await Hive.openBox<String>('videoHistory');

  await Hive.openBox<String>('FavoriteDB');

  await Hive.openBox<Playlist>('playlistDb');
  PhotoManager.clearFileCache();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      theme: ThemeData(
          fontFamily: AppString.kUrbanist,
          useMaterial3: true,
          brightness: Brightness.light,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          disabledColor: Colors.transparent,
          backgroundColor: AppColor.primaryClr,
          scaffoldBackgroundColor: AppColor.bgClr),
      initialRoute: Routes.splash,
      getPages: Routes.routes,
      builder: EasyLoading.init(
        builder: (context, child) {
          SizeUtils().init(context);
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => GalleryDataProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => PreviewPageProvider(),
              ),
            ],
            child: WillPopScope(
              onWillPop: () async {
                bool exit = await showDialog(
                  context: context,
                  builder: (context) => ExitPopup(),
                );
                return exit ?? false;
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ConnectivityWidget(
                    builder: (_, __) => BotToastInit()(_, child),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}


