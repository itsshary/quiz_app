import 'package:flutter/material.dart';
import 'package:quiz_app/routes/routes_name.dart';
import 'package:quiz_app/utill/app_constants.dart';
import 'package:quiz_app/utill/color_resources.dart';
import 'package:quiz_app/utill/dimensions.dart';
import 'package:quiz_app/utill/images.dart';
import 'package:quiz_app/utill/roundbutton.dart';
import 'package:quiz_app/utill/styles.dart';

class StartingView extends StatefulWidget {
  const StartingView({super.key});

  @override
  State<StartingView> createState() => _StartingViewState();
}

class _StartingViewState extends State<StartingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.blackBackroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                      text: '${AppConstants.taglineone}\n',
                      style: tagLineOne(context)),
                  TextSpan(
                    text: AppConstants.secondtagline,
                    style: tagLineTwo(context),
                  ),
                ],
              ),
            ),
            CircleAvatar(
              radius: Dimensions.avaterRadiusLarge,
              backgroundColor: ColorResources.whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Image.asset(
                  AppImages.logo,
                ),
              ),
            ),
            MyButton(
              title: AppConstants.letstart,
              ontap: () {
                Navigator.pushReplacementNamed(context, Routesname.homeView);
              },
              bgcolor: ColorResources.buttonColor,
              textColor: ColorResources.whiteColor,
            )
          ],
        ),
      ),
    );
  }
}
