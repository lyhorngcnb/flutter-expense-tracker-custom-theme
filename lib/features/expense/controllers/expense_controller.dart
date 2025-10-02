import 'package:expensetracker/core/widgets/custom_snackbar.dart' show CustomSnackbar;
import 'package:get/get.dart';

class ExpenseController extends GetxController {
  var isLoading = false.obs;

  Future<void> saveExpense(Map<String, dynamic> expenseData) async {
    isLoading.value = true;
    try {
      // Call your API
      // await api.post('/expenses', expenseData);

      // Navigate back
      Get.back();
      CustomSnackbar.showSuccess(
          Get.context!,
          'expense_saved_successfully'.tr
      );
    } catch (e) {
      CustomSnackbar.showError(
          Get.context!,
          'failed_to_save_expense'.tr
      );
    } finally {
      isLoading.value = false;
    }
  }
}