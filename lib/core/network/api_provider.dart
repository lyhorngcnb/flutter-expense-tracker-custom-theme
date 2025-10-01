import 'package:get/get.dart';
import 'api_endpoints.dart';

class ApiProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = ApiEndpoints.baseUrl;
    httpClient.timeout = const Duration(seconds: 10);
    super.onInit();
  }

  Future<Response> login(String username, String password) {
    return post(ApiEndpoints.login, {
      "username": username,
      "password": password,
    });
  }

  Future<Response> fetchData(String token) {
    return get(ApiEndpoints.data,
        headers: {"Authorization": "Bearer $token"});
  }
}
