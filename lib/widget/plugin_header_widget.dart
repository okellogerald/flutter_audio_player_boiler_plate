// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PluginHeaderWidget extends StatefulWidget {
  final VoidCallback? onBackPressed;
  final String header;
  final bool showBackButton;
  bool showBorder = true;

  PluginHeaderWidget(
      {Key? key,
      required this.header,
      this.showBackButton = true,
      this.onBackPressed,
      required this.showBorder})
      : super(key: key);

  @override
  _PluginHeaderWidgetState createState() => _PluginHeaderWidgetState();
}

class _PluginHeaderWidgetState extends State<PluginHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        // color: Colors.red,
        border: widget.showBorder == true
            ? Border(
                bottom: BorderSide(width: 1, color: Colors.grey),
              )
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: widget.showBackButton == true
                    ? InkWell(
                        onTap: widget.onBackPressed ??
                            () {
                              Get.back(id: 1);
                            },
                        child: SvgPicture.asset(
                            "assets/icons/shared/back_arrow.svg",
                            width: 40,
                            height: 40),
                      )
                    : Container(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              // Screen header
              widget.header,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
