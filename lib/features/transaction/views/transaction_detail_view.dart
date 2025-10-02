
// ==================== 7. VIEW: transaction_detail_view.dart ====================
import 'package:expensetracker/features/transaction/models/transaction_model.dart';
import 'package:expensetracker/features/transaction/transaction/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:expensetracker/core/widgets/custom_app_bar.dart';
import 'package:expensetracker/core/widgets/custom_button.dart';
import 'package:expensetracker/core/widgets/custom_card.dart';
import 'package:expensetracker/core/widgets/badge_widget.dart';
import 'package:expensetracker/core/widgets/custom_dialog.dart';
import 'package:expensetracker/core/routes/app_routes.dart';
import 'package:share_plus/share_plus.dart';

class TransactionDetailView extends StatelessWidget {
  final TransactionController controller = Get.find();

  TransactionDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String transactionId = Get.arguments as String;
    final transaction = controller.getTransactionById(transactionId);

    if (transaction == null) {
      return Scaffold(
        appBar: CustomAppBar(title: 'transaction_detail'.tr),
        body: Center(
          child: Text('transaction_not_found'.tr),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'transaction_detail'.tr,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Get.toNamed(
                AppRoutes.editTransaction,
                arguments: transaction.id,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _showDeleteDialog(context, transaction.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Amount Card
            CustomCard(
              margin: EdgeInsets.zero,
              child: Column(
                children: [
                  Icon(
                    _getCategoryIcon(transaction.category),
                    size: 64,
                    color: _getCategoryColor(transaction.category),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    transaction.description,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${transaction.type == TransactionType.expense ? '-' : '+'}\ ${transaction.amount}',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: transaction.type == TransactionType.expense
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Details Section
            Text(
              'details'.tr,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            CustomCard(
              margin: EdgeInsets.zero,
              child: Column(
                children: [
                  _buildDetailRow(
                    context,
                    'category'.tr,
                    transaction.category,
                    Icons.category,
                    badge: true,
                  ),
                  Divider(),
                  _buildDetailRow(
                    context,
                    'type'.tr,
                    transaction.type == TransactionType.expense
                        ? 'expense'.tr
                        : 'income'.tr,
                    Icons.swap_vert,
                  ),
                  Divider(),
                  _buildDetailRow(
                    context,
                    'date'.tr,
                    _formatDate(transaction.date),
                    Icons.calendar_today,
                  ),
                  Divider(),
                  _buildDetailRow(
                    context,
                    'time'.tr,
                    _formatTime(transaction.date),
                    Icons.access_time,
                  ),
                  if (transaction.isRecurring) ...[
                    Divider(),
                    _buildDetailRow(
                      context,
                      'recurring'.tr,
                      'monthly'.tr,
                      Icons.repeat,
                    ),
                  ],
                ],
              ),
            ),

            if (transaction.note != null && transaction.note!.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text(
                'notes'.tr,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              CustomCard(
                margin: EdgeInsets.zero,
                child: Text(
                  transaction.note!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],

            const SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'share'.tr,
                    onPressed: () => _shareTransaction(transaction),
                    isOutlined: true,
                    icon: Icons.share,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: 'edit'.tr,
                    onPressed: () {
                      Get.toNamed(
                        AppRoutes.editTransaction,
                        arguments: transaction.id,
                      );
                    },
                    icon: Icons.edit,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: 'delete_transaction'.tr,
              onPressed: () => _showDeleteDialog(context, transaction.id),
              backgroundColor: Colors.red,
              icon: Icons.delete,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      BuildContext context,
      String label,
      String value,
      IconData icon, {
        bool badge = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withOpacity(0.6),
              ),
            ),
          ),
          badge
              ? BadgeWidget(text: value)
              : Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String id) async {
    final confirm = await CustomDialog.showConfirmDialog(
      context: context,
      title: 'delete_transaction'.tr,
      message: 'delete_confirmation_message'.tr,
      confirmText: 'delete'.tr,
      cancelText: 'cancel'.tr,
      isDangerous: true,
    );

    if (confirm == true) {
      await controller.deleteTransaction(id);
      Get.back();
    }
  }

  void _shareTransaction(TransactionModel transaction) {
    final text = '''
${transaction.description}
${transaction.type == TransactionType.expense ? 'Expense' : 'Income'}: \${transaction.amount.toStringAsFixed(2)}
Category: ${transaction.category}
Date: ${_formatDate(transaction.date)}
${transaction.note != null ? '\nNote: ${transaction.note}' : ''}
''';

    Share.share(text, subject: transaction.description);
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Colors.orange;
      case 'shopping':
        return Colors.pink;
      case 'transport':
        return Colors.blue;
      case 'entertainment':
        return Colors.purple;
      case 'health':
        return Colors.red;
      case 'salary':
      case 'freelance':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.restaurant;
      case 'shopping':
        return Icons.shopping_bag;
      case 'transport':
        return Icons.directions_car;
      case 'entertainment':
        return Icons.movie;
      case 'health':
        return Icons.fitness_center;
      case 'salary':
      case 'freelance':
        return Icons.attach_money;
      default:
        return Icons.more_horiz;
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}