import 'package:euda_app/const/asset_images.dart';
import 'package:euda_app/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterButton extends StatefulWidget {
  final VoidCallback onPressed;
  const FilterButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: themeColorAccent,
          fixedSize: Size(48, 48),
          padding: const EdgeInsets.all(0),
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          )),
      child: SvgPicture.asset(
        AssetImages.filterIcon,
        height: 30,
      ),
      onPressed: widget.onPressed,
    );
  }
}
