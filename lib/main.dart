import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/theme_provider.dart';
import 'package:quiz_app/routes/routes.dart';
import 'package:quiz_app/routes/routes_name.dart';
import 'package:quiz_app/utill/app_constants.dart';
import 'package:quiz_app/utill/color_resources.dart';
import 'package:quiz_app/view/splash_view/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      initialRoute: Routesname.splashView,
      onGenerateRoute: Routes.generateRoutes,
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: ColorResources.lightTheme,
      darkTheme: ColorResources.darkTheme,
      themeMode: themeProvider.themeMode,
      home: const SplashView(),
    );
  }
}
