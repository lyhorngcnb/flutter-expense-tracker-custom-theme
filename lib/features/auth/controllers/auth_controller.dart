import 'package:get/get.dart';
import '../../../core/network/api_provider.dart';
import '../../../core/utils/storage_service.dart';
import '../../../core/routes/app_routes.dart';

class AuthController extends GetxController {
  final ApiProvider api = Get.find();
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login(String username, String password) async {
    isLoading.value = true;

    try {
      // TODO: Add your actual API call here
      // final response = await api.post('/login', {
      //   'username': username,
      //   'password': password,
      // });

      // Simulate API call for now
      await Future.delayed(Duration(seconds: 1));

      // TODO: Save token after successful login
      // await StorageService.saveToken(response.data['token']);

      // Navigate to home
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      // Show error message
      Get.snackbar(
        'error'.tr,
        'login_failed'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
        duration: Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    StorageService.clearToken();
    Get.offAllNamed(AppRoutes.login);
  }
}