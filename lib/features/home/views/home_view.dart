import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/controllers/auth_controller.dart';

class HomeView extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('home'.tr), actions: [
        IconButton(onPressed: () => Get.toNamed('/settings'), icon: Icon(Icons.settings)),
        IconButton(onPressed: authController.logout, icon: Icon(Icons.logout)),
      ]),
      body: Center(child: Text('welcome'.tr)),
    );
  }
}
