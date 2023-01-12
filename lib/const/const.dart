// import 'package:euda_app/dto/pulse_survey_dto.dart';
import 'package:flutter/material.dart';

const Color darkGrayBackground = Color.fromRGBO(93, 104, 116, 1);
const Color greenBackground = Color.fromRGBO(57, 185, 191, 1);
const Color darkBackground = Color.fromRGBO(20, 18, 39, 1.0);

const Color themeColorAccent = Color(0xFF39B9BF);
const Color grayBackground = Color(0xFF354251);

const String eudaLogoUrl =
    "https://res.cloudinary.com/eudawellbeing/image/upload/v1629195772/assets/websiteImages/euda-white_1_xdulsf.png";

Widget topSpace(context) {
  return SizedBox(height: MediaQuery.of(context).size.height * 0.02);
}

//No pulse Survey text
const String txtForNoPulseSurvey =
    "Hooray! You have no new pulse survey to complete. Have a great day!";
