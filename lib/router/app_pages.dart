import 'package:euda_app/view/my_toolkit/widgets/meditation/meditation_list.dart';
import 'package:euda_app/view/my_toolkit/widgets/meditation/meditation_player.dart';

import 'package:euda_app/view/onboarding/splash_view.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.MEDITATION,
      page: () => const MyToolKitMeditation(),
    ),
    GetPage(
      name: Routes.PLAYER,
      page: () => const MyToolKitPlayer(),
    ),
  ];

  // static Route pluginOnGenerate(RouteSettings settings) {
  //   if (settings.name == '/') {
  //     return GetPageRoute(
  //       page: () => const Dashboard(),
  //       title: "Dashboard",
  //     );
  //   } else if (settings.name == Routes.MYHISTORY) {
  //     return GetPageRoute(
  //       page: () => const MyToolKitMyHistory(),
  //       title: "My History",
  //     );
  //   } else if (settings.name == Routes.CINEMA) {
  //     return GetPageRoute(
  //       page: () => const MyToolKitCinema(),
  //     );
  //   } else if (settings.name == Routes.CHECKIN) {
  //     return GetPageRoute(
  //       page: () => const CheckInScreen(),
  //     );
  //   } else if (settings.name == Routes.RESOURCE) {
  //     return GetPageRoute(
  //       page: () => const MyToolKitResources(),
  //     );
  //   } else if (settings.name == Routes.EVENT) {
  //     return GetPageRoute(
  //       page: () => const MyToolKitEvent(),
  //     );
  //   } else if (settings.name == Routes.SUPPORTLINK) {
  //     return GetPageRoute(
  //       page: () => const MyToolSupportLinks(),
  //     );
  //   } else if (settings.name == Routes.MEDITATION) {
  //     return GetPageRoute(
  //       page: () => const MyToolKitMeditation(),
  //     );
  //   }
  //   } else {
  //     return GetPageRoute(
  //       page: () => const Scaffold(),
  //     );
  //   }
  // }
}
