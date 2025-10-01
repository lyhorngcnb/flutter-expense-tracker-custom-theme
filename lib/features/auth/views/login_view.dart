import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  final AuthController controller = Get.find();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: usernameController, decoration: InputDecoration(labelText: 'username'.tr)),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'password'.tr), obscureText: true),
            const SizedBox(height: 20),
            Obx(() => ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () => controller.login(usernameController.text, passwordController.text),
              child: controller.isLoading.value ? CircularProgressIndicator() : Text('login'.tr),
            )),
          ],
        ),
      ),
    );
  }
}
