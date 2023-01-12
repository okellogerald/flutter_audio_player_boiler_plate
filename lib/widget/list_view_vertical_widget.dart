import 'package:euda_app/const/asset_images.dart';
import 'package:euda_app/provider/meditation_provider.dart';

import 'package:euda_app/router/app_pages.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ListViewVerticalWidget extends StatefulWidget {
  final List<dynamic> items;
  final String target;
  const ListViewVerticalWidget(
      {Key? key, required this.items, required this.target})
      : super(key: key);

  @override
  _ListViewVerticalWidgetState createState() => _ListViewVerticalWidgetState();
}

class _ListViewVerticalWidgetState extends State<ListViewVerticalWidget> {
  late String iconPath;

  @override
  void initState() {
    if (widget.target == 'meditation') {
      iconPath = "assets/icons/shared/Play.png";
    } else if (widget.target == 'cinema') {
      iconPath = "assets/icons/shared/Play.png";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var items;
    double imageOpacity = 0.0;
    var imageSize;
    bool noRecordsToShow = false;
    int numberOfShowItems;

    if (widget.target == 'meditation') {
      iconPath = "assets/icons/shared/Play.png";
      final meditationProvider = Provider.of<MeditationProvider>(context);
      items = meditationProvider.meditations;
      imageSize = BoxFit.cover;
      imageOpacity = 0.3;
      numberOfShowItems =
          items.where((el) => el.metaData.show == true).toList().length;
      numberOfShowItems == 0 ? noRecordsToShow = true : noRecordsToShow = false;
    }

    if (noRecordsToShow == true) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 5),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Center(
            child: Text(
              "No results found",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 5),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(
                  0, 0, 0, MediaQuery.of(context).size.height * 0.4),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (ctx, index) {
                if (items[index].metaData.show == true) {
                  return InkWell(
                      onTap: () {
                        if (widget.target == 'meditation') {
                          Get.toNamed(Routes.PLAYER, arguments: {
                            'title': items[index].metaData.title,
                            'imgLink': items[index].metaData.imgLink,
                            'videoLink': items[index].metaData.link,
                          });
                        }
                      },
                      child: Column(children: <Widget>[
                        Container(
                          height: 100,
                          child: Card(
                            color: Colors.white.withOpacity(0.8),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color.fromRGBO(246, 246, 246, 1.0),
                                  width: 1),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 145,
                                          decoration: const BoxDecoration(
                                            // color: Colors.red,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(18),
                                            ),
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          child: Image.network(
                                            items[index].metaData.imgLink,
                                            fit: BoxFit.cover,
                                            width: 145,
                                            height: 100,
                                            // colorFilter: ColorFilter.mode(
                                            //     Colors.black.withOpacity(0.4), BlendMode.darken),
                                          ),
                                        ),
                                        Container(
                                          decoration: ['cinema', 'meditation']
                                                  .contains(widget.target)
                                              ? BoxDecoration(
                                                  // color: Colors.blue,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(18),
                                                  ),
                                                  border: Border.all(
                                                    width: 0.5,
                                                    color: Colors.white30,
                                                  ),
                                                  gradient:
                                                      const LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.transparent,
                                                      Colors.transparent,
                                                      Color(0xCC354251),
                                                      Color(0xFF354251),
                                                    ],
                                                  ),
                                                )
                                              : null,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Row(
                                                children: [
                                                  const SizedBox(width: 5.0),
                                                  widget.target == 'course' ||
                                                          widget.target ==
                                                              'support_links' ||
                                                          widget.target ==
                                                              'resource'
                                                      ? Container()
                                                      : Image.asset(AssetImages
                                                          .clockIcon),
                                                  const SizedBox(width: 5.0),
                                                  Text(
                                                    "${widget.target == 'cinema' || widget.target == 'meditation' ? items[index].metaData.duration.replaceAll("minute", "min").replaceAll("seconds", "sec") : ''}",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                widget.target == 'support_links' ||
                                        widget.target == 'meditation' ||
                                        widget.target == 'course'
                                    ? Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              child: Center(
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${items[index].metaData.title}",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                        ),
                                      )
                                    : Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              child: Center(
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${items[index].metaData.title}",
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      "${items[index].metaData.description}",
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0x66192196),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 13,
                                                        letterSpacing: 0.5,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ]));
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      );
    }
  }
}
