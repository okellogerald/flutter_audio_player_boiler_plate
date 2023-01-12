import 'package:euda_app/const/const.dart';
import 'package:flutter/material.dart';

/// A custom TextFormField
///
/// Add anything that needs to be configured
/// from the TextFormField as a parameter

class ThemeTextInput extends StatefulWidget {
  final String? hintText;
  final FormFieldValidator? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String> onSubmitted;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final String label;
  final bool isPassword;

  const ThemeTextInput({
    Key? key,
    required this.label,
    required this.onSubmitted,
    this.hintText,
    this.onChanged,
    this.controller,
    this.validator,
    this.suffixIcon,
    this.isPassword = false,
  }) : super(key: key);

  @override
  _ThemeTextInputState createState() => _ThemeTextInputState();
}

class _ThemeTextInputState extends State<ThemeTextInput> {
  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400);
    final hintStyle = TextStyle(
        color: Colors.white.withOpacity(0.5),
        fontSize: 14,
        fontWeight: FontWeight.w400);

    final suffixIcon = (widget.isPassword)
        ? IconButton(
            icon: const Icon(Icons.remove_red_eye_outlined),
            color: const Color(0xFF354251),
            onPressed: () {},
          )
        : widget.suffixIcon;

    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: darkGrayBackground,
              border: Border.all(color: Colors.black26),
            ),
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              validator: widget.validator,
              controller: widget.controller,
              obscureText: widget.isPassword,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8),
                suffixIcon: suffixIcon,
                hintText: widget.hintText,
                hintStyle: hintStyle,
                border: InputBorder.none,
              ),
              style: style,
              onChanged: widget.onChanged,
              onFieldSubmitted: widget.onSubmitted,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: TextFieldLabel(label: widget.label),
          )
        ],
      ),
    );
  }
}

class TextFieldLabel extends StatelessWidget {
  const TextFieldLabel({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.25),
        border: Border.all(color: Colors.white30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      margin: const EdgeInsets.only(left: 15),
      height: 30,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white.withOpacity(0.69),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
