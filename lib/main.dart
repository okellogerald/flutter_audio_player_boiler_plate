import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';

import 'controllers/audio_state_controller.dart';
import 'views/audios_screen.dart';
import 'views/foreground_player.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => AudioManager());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initForegroundPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const AudiosScreen(),
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
      ),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.example.audio_player_boilerplate',
        androidNotificationChannelName: 'Audio Player',
        androidNotificationIcon: 'mipmap/launcher_icon',
      ),
    );
  }
}
