
// ==================== 6. VIEW: transactions_list_view.dart ====================
import 'package:expensetracker/core/widgets/filter_bottom_sheet.dart';
import 'package:expensetracker/core/widgets/transaction_group_header.dart';
import 'package:expensetracker/core/widgets/transaction_item.dart';
import 'package:expensetracker/features/transaction/models/transaction_model.dart';
import 'package:expensetracker/features/transaction/transaction/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expensetracker/core/widgets/custom_app_bar.dart';
import 'package:expensetracker/core/widgets/search_bar_widget.dart';
import 'package:expensetracker/core/widgets/loading_indicator.dart';
import 'package:expensetracker/core/widgets/empty_state.dart';
import 'package:expensetracker/core/routes/app_routes.dart';

class TransactionsListView extends StatelessWidget {
  final TransactionController controller = Get.put(TransactionController());
  final TextEditingController searchController = TextEditingController();

  TransactionsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'transactions'.tr,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Get.bottomSheet(
                FilterBottomSheet(controller: controller),
                isScrollControlled: true,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBarWidget(
              controller: searchController,
              hint: 'search_transactions'.tr,
              onChanged: (value) {
                controller.searchQuery.value = value;
              },
              onClear: () {
                searchController.clear();
                controller.searchQuery.value = '';
              },
            ),
          ),

          // Summary Card
          Obx(() => Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem(
                  context,
                  'expense'.tr,
                  controller.totalExpense,
                  Colors.red.shade100,
                  Icons.arrow_downward,
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withOpacity(0.3),
                ),
                _buildSummaryItem(
                  context,
                  'income'.tr,
                  controller.totalIncome,
                  Colors.green.shade100,
                  Icons.arrow_upward,
                ),
              ],
            ),
          )),
          const SizedBox(height: 16),

          // Transactions List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return LoadingIndicator(message: 'loading_transactions'.tr);
              }

              if (controller.filteredTransactions.isEmpty) {
                return EmptyState(
                  icon: Icons.receipt_long_outlined,
                  title: 'no_transactions_found'.tr,
                  message: 'try_different_filters'.tr,
                  actionText: 'clear_filters'.tr,
                  onAction: () => controller.clearFilters(),
                );
              }

              final grouped = controller.groupedTransactions;

              return RefreshIndicator(
                onRefresh: controller.loadTransactions,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: grouped.length,
                  itemBuilder: (context, index) {
                    final dateKey = grouped.keys.elementAt(index);
                    final transactions = grouped[dateKey]!;
                    final dayTotal = transactions.fold<double>(
                      0,
                          (sum, t) => sum + (t.type == TransactionType.expense ? t.amount : 0),
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TransactionGroupHeader(
                          title: dateKey,
                          totalAmount: dayTotal,
                        ),
                        ...transactions.map((transaction) {
                          return TransactionItem(
                            transaction: transaction,
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.transactionDetail,
                                arguments: transaction.id,
                              );
                            },
                            onDelete: () {
                              controller.deleteTransaction(transaction.id);
                            },
                            onEdit: () {
                              Get.toNamed(
                                AppRoutes.editTransaction,
                                arguments: transaction.id,
                              );
                            },
                          );
                        }).toList(),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.addexpense),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryItem(
      BuildContext context,
      String label,
      double amount,
      Color color,
      IconData icon,
      ) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(icon, size: 16, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          amount.toStringAsFixed(2),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

      ],
    );
  }
}
