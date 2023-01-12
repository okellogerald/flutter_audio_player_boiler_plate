import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyToolKitPlugIn extends StatefulWidget {
  final String link;
  final String title;
  final String path;

  @override
  _MyToolKitPlugInState createState() => _MyToolKitPlugInState();

  const MyToolKitPlugIn(this.link, this.title, this.path, {Key? key})
      : super(key: key);
}

class _MyToolKitPlugInState extends State<MyToolKitPlugIn> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.link), fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            )
          ],
        ),
        onTap: () => {Get.toNamed(widget.path)},
      ),
    );
  }
}
