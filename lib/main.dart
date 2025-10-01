import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/translations/translation_service.dart';
import 'core/network/api_provider.dart';
import 'features/auth/controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  final translations = await TranslationService.init();

  // Global DI
  Get.put(ApiProvider());        // API provider
  Get.put(AuthController());     // AuthController is now available everywhere

  runApp(MyApp(translations));
}


class MyApp extends StatelessWidget {
  final TranslationService translations;
  MyApp(this.translations);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: translations,
      locale: const Locale('en', 'US'),
      fallbackLocale: TranslationService.fallbackLocale,
      theme: AppTheme.lightTheme(Get.locale ?? Locale('en', 'US')),
      darkTheme: AppTheme.darkTheme(Get.locale ?? Locale('en', 'US')),
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
