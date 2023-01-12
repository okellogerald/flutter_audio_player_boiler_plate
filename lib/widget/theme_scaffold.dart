import 'package:euda_app/const/const.dart';
import 'package:euda_app/widget/plugin_header_widget.dart';
import 'package:flutter/material.dart';

class ThemeScaffold extends StatelessWidget {
  const ThemeScaffold(
      {Key? key,
      required this.children,
      required this.title,
      this.onBackPressed})
      : super(key: key);
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
                const SizedBox(height: 50),
                PluginHeaderWidget(
                    header: title,
                    onBackPressed: onBackPressed,
                    showBorder: true),
              ] +
              children,
        ),
      ),
    );
  }
}
