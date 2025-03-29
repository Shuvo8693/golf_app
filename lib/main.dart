
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/common/controller/localization_controller.dart';
import 'package:golf_game_play/common/controller/theme_controller.dart';
import 'package:golf_game_play/common/themes/light_theme.dart';
import 'package:golf_game_play/sk_key.dart';

import 'app/routes/app_pages.dart';
import 'common/app_constant/app_constant.dart';
import 'common/di/di.dart';
import 'common/prefs_helper/prefs_helpers.dart';
import 'common/widgets/message.dart';

String token = '';
String myId = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = SKey.sPubTestKey;
  Map<String, Map<String, String>> _languages = await init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_){
    runApp(MyApp(
      languages: _languages,
    ));
  });
  token = await PrefsHelper.getString('token');
  myId = await PrefsHelper.getString('userId');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languages});

  final Map<String, Map<String, String>> languages;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return ScreenUtilInit(
            designSize: const Size(393, 852),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return GetMaterialApp(
                title: AppConstants.APP_NAME,
                debugShowCheckedModeBanner: false,
                navigatorKey: Get.key,
                // theme: themeController.darkTheme ? dark(): light(),
                theme: light(),
                defaultTransition: Transition.topLevel,
                locale: localizeController.locale,
                translations: Messages(languages: languages),
                fallbackLocale: Locale(AppConstants.languages[0].languageCode,
                    AppConstants.languages[0].countryCode),
                transitionDuration: const Duration(milliseconds: 500),
                getPages: AppPages.routes,
                initialRoute: authenticationRoute(),
              );
            });
      });
    });
  }

  String authenticationRoute() {
    if (token.isNotEmpty) {
      return Routes.HOME;
    } else {
      return AppPages.INITIAL;
    }
  }
}
