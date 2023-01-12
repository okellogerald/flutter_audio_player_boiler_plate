import 'dart:async';
import 'package:euda_app/const/const.dart';

import 'package:euda_app/router/app_pages.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../provider/meditation_provider.dart';

import 'dart:convert';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String getBrandImage;

  @override
  void initState() {
    Timer(
      const Duration(seconds: 1),
      () async {
        Get.offAllNamed(Routes.MEDITATION);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("assets/images/euda_splash.gif"),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
