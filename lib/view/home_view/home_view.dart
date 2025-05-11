import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/theme_provider.dart';
import 'package:quiz_app/utill/app_constants.dart';
import 'package:quiz_app/utill/color_resources.dart';
import 'package:quiz_app/utill/dimensions.dart';
import 'package:quiz_app/utill/images.dart';
import 'package:quiz_app/utill/styles.dart';
import 'package:quiz_app/view/home_view/widget/show_dialog_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          )
        ],
        centerTitle: true,
        title: Text(
          AppConstants.appName,
          style: commonTextStyle(context),
        ),
        elevation: 0,
        backgroundColor:
            themeProvider.isDarkMode ? Colors.black : Colors.amber.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: GridView.builder(
            itemCount: AppConstants.categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: Dimensions.mainAxisSpacing,
              childAspectRatio: Dimensions.aspectRatio,
              crossAxisSpacing: Dimensions.crossAxisSpacing,
              crossAxisCount: Dimensions.crossAxisCount,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  showStartQuizDialog(context, AppConstants.categories[index]);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Card(
                        color: themeProvider.isDarkMode
                            ? ColorResources.amberColor
                            : ColorResources.amberShades300,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                Dimensions.radiusDefault)),
                        elevation: Dimensions.smallElevation,
                        child: SizedBox(
                          height: Dimensions.largeHeight,
                          width: Dimensions.largeHeight,
                          child: Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeExtraSmall),
                            child: Image.asset(
                              AppImages.photoList[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppConstants.categories[index],
                      style: mediumTextStyle(context),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
