import 'package:euda_app/const/const.dart';
import 'package:euda_app/provider/meditation_provider.dart';

import 'package:euda_app/widget/list_view_vertical_widget.dart';
import 'package:euda_app/widget/plugin_header_widget.dart';
import 'package:euda_app/widget/plugin_header_with_goback_widget.dart';
import 'package:euda_app/widget/plugin_sub_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyToolKitMeditation extends StatefulWidget {
  const MyToolKitMeditation({Key? key}) : super(key: key);

  @override
  _MyToolKitMeditationState createState() => _MyToolKitMeditationState();
}

class _MyToolKitMeditationState extends State<MyToolKitMeditation> {
  void initState() {
    Future.microtask(() {
      Provider.of<MeditationProvider>(context, listen: false).fetch();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final meditationProvider = Provider.of<MeditationProvider>(context);
    var meditationList = meditationProvider.meditations;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // const SizedBox(height: 50),
            // const PluginHeaderWidget(header: "Meditation"),
            Expanded(
              child: (meditationList.isNotEmpty &&
                      meditationProvider.loaded == true)
                  ? ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        // PluginSubHeaderWidget(subHeaderText: 'Latest'),
                        // Container(height: 10),
                        // const SizedBox(height: 20),

                        PluginHeaderWidget(
                            header: "Meditations",
                            showBackButton: false,
                            showBorder: false),
                        // SearchBar(),
                        // // CarouselWidget(
                        //     items: meditationList, target: "meditation"),
                        // const SizedBox(height: 20),
                        // PluginSubHeaderWidget(subHeaderText: 'Meditation'),
                        ListViewVerticalWidget(
                            items: meditationList, target: "meditation"),
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
