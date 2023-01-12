import 'dart:async';

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
    //
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
}
