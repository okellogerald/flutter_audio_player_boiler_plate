import 'package:flutter/material.dart';

class PluginSubHeaderWidget extends StatefulWidget {
  String subHeaderText;
  PluginSubHeaderWidget({Key? key, required this.subHeaderText})
      : super(key: key);

  @override
  _PluginSubHeaderWidgetState createState() => _PluginSubHeaderWidgetState();
}

class _PluginSubHeaderWidgetState extends State<PluginSubHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.subHeaderText,
            style: const TextStyle(
              color: Colors.white,
              letterSpacing: 1.0,
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
