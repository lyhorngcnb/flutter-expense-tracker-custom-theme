import 'package:get/get.dart';
import '../../../core/utils/storage_service.dart';
import '../../../core/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 2), checkLogin);
  }

  void checkLogin() {
    final token = StorageService.getToken();
    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
