import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/routes/routes_name.dart';

class SplashServices {
  void moveNextScreen(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, Routesname.startingView),
    );
  }
}
