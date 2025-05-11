import 'package:flutter/material.dart';
import 'package:quiz_app/service/splash_services.dart';
import 'package:quiz_app/utill/color_resources.dart';
import 'package:quiz_app/utill/dimensions.dart';
import 'package:quiz_app/utill/images.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    splashServices.moveNextScreen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.blackBackroundColor,
      body: Center(
        child: CircleAvatar(
          radius: Dimensions.avaterRadiusLarge,
          backgroundColor: ColorResources.whiteBackroundColor,
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Image.asset(
                height: Dimensions.extraLargeImageSizs,
                width: Dimensions.extraLargeImageSizs,
                AppImages.logo),
          ),
        ),
      ),
    );
  }
}
