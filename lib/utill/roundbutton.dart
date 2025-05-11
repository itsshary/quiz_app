import 'package:flutter/material.dart';
import 'package:quiz_app/utill/dimensions.dart';
import 'package:quiz_app/utill/styles.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Color bgcolor;
  final Color? textColor;
  final VoidCallback ontap;
  const MyButton(
      {super.key,
      required this.title,
      this.bgcolor = Colors.black,
      required this.ontap,
      this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeExtraLarge),
      child: InkWell(
        onTap: ontap,
        child: Container(
          height: Dimensions.roundedButtonHeight,
          width: Dimensions.roundedButtonWidth,
          decoration: BoxDecoration(
            color: bgcolor,
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          ),
          child: Center(
              child: Text(title, style: roundButtonStyle(context, textColor!))),
        ),
      ),
    );
  }
}
