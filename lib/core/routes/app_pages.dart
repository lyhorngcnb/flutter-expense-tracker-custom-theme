import 'package:expensetracker/features/expense/controllers/expense_controller.dart';
import 'package:expensetracker/features/expense/views/add_expense_view.dart';
import 'package:get/get.dart';
import '../../features/splash/views/splash_view.dart';
import '../../features/splash/controllers/splash_controller.dart';
import '../../features/auth/views/login_view.dart';
import '../../features/auth/controllers/auth_controller.dart';
import '../../features/home/views/home_view.dart';
import '../../features/settings/views/settings_view.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
      binding: BindingsBuilder(() => Get.put(SplashController())),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: BindingsBuilder(() => Get.put(AuthController())),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: BindingsBuilder(() => Get.put(AuthController())),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => SettingsView(),
    ),
    GetPage(
        name: AppRoutes.addexpense,
        page: () => AddExpenseView(),
      binding: BindingsBuilder(() => Get.put(ExpenseController()))
    )
  ];
}
