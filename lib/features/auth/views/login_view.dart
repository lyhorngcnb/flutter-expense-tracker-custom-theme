import 'package:expensetracker/core/widgets/custom_text_field.dart';
import 'package:expensetracker/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo or App Icon
                  Icon(
                    Icons.account_balance_wallet,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),

                  // App Title
                  Text(
                    'welcome_back'.tr,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  Text(
                    'login_subtitle'.tr,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // Username Field
                  CustomTextField(
                    controller: usernameController,
                    label: 'username'.tr,
                    hint: 'enter_username'.tr,
                    // prefixIcon: Icons.person_outline,
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
                  Obx(() => CustomTextField(
                    controller: passwordController,
                    label: 'password'.tr,
                    hint: 'enter_password'.tr,
                    // prefixIcon: Icons.lock_outline,
                    obscureText: !controller.isPasswordVisible.value,
                    suffixIcon: controller.isPasswordVisible.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onSuffixTap: controller.togglePasswordVisibility,
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
                  )),
                  const SizedBox(height: 12),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Navigate to forgot password
                      },
                      child: Text('forgot_password'.tr),
                    ),
                  ),
                  const SizedBox(height: 24),

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
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// ==================== TRANSLATIONS ====================
// Add these translations to your language files

// English (en_US.dart or translations.dart)
/*
'welcome_back': 'Welcome Back',
'login_subtitle': 'Sign in to continue',
'username': 'Username',
'enter_username': 'Enter your username',
'password': 'Password',
'enter_password': 'Enter your password',
'username_required': 'Username is required',
'password_required': 'Password is required',
'password_too_short': 'Password must be at least 6 characters',
'forgot_password': 'Forgot Password?',
'login': 'Login',
'or': 'OR',
'create_account': 'Create Account',
'error': 'Error',
'login_failed': 'Login failed. Please check your credentials.',
*/

// Khmer (km_KH.dart or translations.dart)
/*
'welcome_back': 'សូមស្វាគមន៍',
'login_subtitle': 'ចូលដើម្បីបន្ត',
'username': 'ឈ្មោះអ្នកប្រើប្រាស់',
'enter_username': 'បញ្ចូលឈ្មោះអ្នកប្រើប្រាស់',
'password': 'ពាក្យសម្ងាត់',
'enter_password': 'បញ្ចូលពាក្យសម្ងាត់',
'username_required': 'ត្រូវការឈ្មោះអ្នកប្រើប្រាស់',
'password_required': 'ត្រូវការពាក្យសម្ងាត់',
'password_too_short': 'ពាក្យសម្ងាត់ត្រូវមានយ៉ាងតិច ៦ តួអក្សរ',
'forgot_password': 'ភ្លេចពាក្យសម្ងាត់?',
'login': 'ចូល',
'or': 'ឬ',
'create_account': 'បង្កើតគណនី',
'error': 'កំហុស',
'login_failed': 'ការចូលបានបរាជ័យ។ សូមពិនិត្យមើលព័ត៌មានសម្ងាត់របស់អ្នក។',
*/