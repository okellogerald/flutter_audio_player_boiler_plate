import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PluginHeaderWithGobackWidget extends StatefulWidget {
  final String header;
  const PluginHeaderWithGobackWidget({Key? key, required this.header})
      : super(key: key);

  @override
  State<PluginHeaderWithGobackWidget> createState() =>
      _PluginHeaderWithGobackWidgetState();
}

class _PluginHeaderWithGobackWidgetState
    extends State<PluginHeaderWithGobackWidget> {
  String from = "mytoolkit";
  void initState() {
    super.initState();

    var fromArg = Get.arguments != null ? Get.arguments['from'] : null;

    if (fromArg != null) {
      from = fromArg;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    if (from == 'mytoolkit') {
                      Get.back(id: 1);
                    } else {
                      Get.back();
                    }
                  },
                  child: SvgPicture.asset("assets/icons/shared/back_arrow.svg",
                      width: 45, height: 45),
                )),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            // Screen header
            widget.header,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
