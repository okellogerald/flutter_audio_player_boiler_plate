import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:euda_app/controllers/audio_state_controller.dart';
import 'package:euda_app/provider/meditation_provider.dart';

import 'package:euda_app/router/app_pages.dart';

import 'package:euda_app/view/onboarding/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'view/my_toolkit/widgets/meditation/audio_foreground_player.dart';

// import 'package:package_info_plus/package_info_plus.dart';
//Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {
  // print(message.data['route'].toString());
  // print(message!.notification!.title);
  if (message != null) {
    Get.offAllNamed(Routes.LOGIN);
  }
}

// Future<void> getInitialMessage(RemoteMessage message) async {
//   // print(message.data['route'].toString());
//   // print(message.notification!.title);
//   Get.offAllNamed(Routes.HOME, arguments: {"showBalanceCheckin": true});
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // print(buildNumber);
  // PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //initialise the firebase app and it is a future so need to use await.
  await Firebase.initializeApp();

  //init own thread and init own isolate.
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  // PackageInfo packageInfo = await PackageInfo.fromPlatform();
  // String buildNumber = packageInfo.buildNumber;
  // String value = await VersionService().checkVersion();
  // print(buildNumber);

  Get.lazyPut(() => AudioManager());

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => MeditationProvider(),
      ),
    ], child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String path = 'home';
  @override
  void initState() {
    super.initState();
    _initForegroundPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const SplashScreen(),
      getPages: AppPages.routes,
      // unknownRoute: path == 'home' ? AppPages.routes[4] : AppPages.routes[5],
      theme: ThemeData(fontFamily: 'Manrope'),
      debugShowCheckedModeBanner: false,
    );
  }

  _initForegroundPlayer() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    final audioManager = Get.find<AudioManager>();

    await AudioService.init(
      builder: () => ForegroundPlayer(
        audioSession: session,
        audioManager: audioManager,
        /*     audioContentStream: ref.read(audioContentStreamProvider.stream),
        audioPositionStream: ref.read(audioPositionStreamProvider.stream),
        audioStateStream: ref.read(audioStateStreamProvider.stream),*/
      ),
      config: const AudioServiceConfig(
          androidNotificationChannelId: 'com.euda.euda_app',
          androidNotificationChannelName: 'Euda',
          androidNotificationIcon: 'mipmap/launcher_icon'),
    );
  }
}
