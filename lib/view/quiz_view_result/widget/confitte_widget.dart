import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/routes/routes_name.dart';
import 'package:quiz_app/utill/app_constants.dart';
import 'package:quiz_app/utill/color_resources.dart';
import 'package:quiz_app/utill/dimensions.dart';
import 'package:quiz_app/utill/images.dart';

void showCongratulationsDialog(
    BuildContext context, ConfettiController confettiController) {
  showDialog(
    context: context,
    builder: (context) {
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          AlertDialog(
            title: const Text('🎉 Congratulations!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppImages.winner,
                    height: Dimensions.mediumImageSizs),
                const SizedBox(height: 16),
                const Text(
                  AppConstants.questionRight,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  confettiController.stop();

                  Navigator.pushReplacementNamed(context, Routesname.homeView);
                },
                child: const Text('OK'),
              ),
            ],
          ),
          Positioned(
            top: -10,
            child: ConfettiWidget(
              confettiController: confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: ColorResources.confitteColors,
            ),
          ),
        ],
      );
    },
  );
}
