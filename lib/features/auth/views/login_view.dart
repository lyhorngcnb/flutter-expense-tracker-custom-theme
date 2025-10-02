import 'package:expensetracker/core/utils/app_icons.dart';
import 'package:expensetracker/core/widgets/custom_text_field.dart';
import 'package:expensetracker/core/widgets/custom_button.dart';
import 'package:expensetracker/core/widgets/custom_text_field_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  final AuthController controller = Get.find();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Container(
                    width: 200,
                    height: 143,
                    child: SvgPicture.asset(
                      AppIcons.wallet,
                      width: 120,
                      height: 120,
                    ),
                  ),

                  SizedBox(height: 45),
                  Text(
                      'Login to Your Account',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  const SizedBox(height: 24),

                  // Username Field
                  CustomTextField2(
                    controller: usernameController,
                    label: 'username'.tr,
                    hint: 'enter_username'.tr,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'username_required'.tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                // Password Field
                  CustomTextField2(
                    controller: passwordController,
                    label: 'password'.tr,
                    hint: 'enter_password'.tr,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'password_required'.tr;
                      }
                      if (value.length < 6) {
                        return 'password_too_short'.tr;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  // Forgot Password
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //     onPressed: () {
                  //       // Navigate to forgot password
                  //     },
                  //     child: Text('forgot_password'.tr),
                  //   ),
                  // ),
                  const SizedBox(height: 24),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Login Button
                      Obx(() => CustomButton(
                        text: 'login'.tr,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.login(
                              usernameController.text,
                              passwordController.text,
                            );
                          }
                        },
                        isLoading: controller.isLoading.value,
                        icon: Icons.login,
                        height: 56,
                      )),
                      const SizedBox(height: 16),

                      // Or Divider
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'or'.tr,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Sign Up Button
                      CustomButton(
                        text: 'create_account'.tr,
                        onPressed: () {
                          // Navigate to sign up
                        },
                        isOutlined: true,
                        icon: Icons.person_add,
                        height: 56,
                      ),
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
