import 'package:flutter/material.dart';
import 'package:quiz_app/utill/dimensions.dart';

TextStyle commonTextStyle(BuildContext context) => TextStyle(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
      fontWeight: FontWeight.bold,
    );

TextStyle mediumTextStyle(BuildContext context) => TextStyle(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
      fontSize: Dimensions.fontSizeExtraLarge,
      fontWeight: FontWeight.bold,
    );

// just for first screen styling
TextStyle tagLineOne(BuildContext context) => const TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

TextStyle tagLineTwo(BuildContext context) => const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Colors.white70,
    );

// button style
TextStyle roundButtonStyle(BuildContext context, Color textColor) =>
    TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold);
