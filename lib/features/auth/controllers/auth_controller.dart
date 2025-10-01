import 'package:get/get.dart';
import '../../../core/network/api_provider.dart';
import '../../../core/utils/storage_service.dart';
import '../../../core/routes/app_routes.dart';

class AuthController extends GetxController {
  final ApiProvider api = Get.find();
  var isLoading = false.obs;

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    final response = await api.login(username, password);
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.home);
    // if (response.statusCode == 200) {
    //   final token = response.body['token'];
    //   await StorageService.saveToken(token);
    //   Get.offAllNamed(AppRoutes.home);
    // } else {
    //   Get.snackbar("Error", "Login failed");
    // }
  }

  void logout() {
    StorageService.clearToken();
    Get.offAllNamed(AppRoutes.login);
  }
}
