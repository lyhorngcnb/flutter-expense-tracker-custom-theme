// ==================== 4. WIDGET: filter_bottom_sheet.dart ====================
import 'package:expensetracker/features/transaction/models/transaction_model.dart';
import 'package:expensetracker/features/transaction/transaction/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expensetracker/core/widgets/custom_button.dart';
import 'package:expensetracker/core/widgets/section_header.dart';

class FilterBottomSheet extends StatelessWidget {
  final TransactionController controller;

  const FilterBottomSheet({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            'filters'.tr,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // Period Filter
          SectionHeader(
            title: 'period'.tr,
            padding: EdgeInsets.zero,
          ),
          const SizedBox(height: 12),
          Obx(() => Wrap(
            spacing: 8,
            runSpacing: 8,
            children: FilterPeriod.values.map((period) {
              return ChoiceChip(
                label: Text(_getPeriodLabel(period)),
                selected: controller.filterPeriod.value == period,
                onSelected: (selected) {
                  if (selected) {
                    controller.filterPeriod.value = period;
                  }
                },
              );
            }).toList(),
          )),
          const SizedBox(height: 24),

          // Type Filter
          SectionHeader(
            title: 'type'.tr,
            padding: EdgeInsets.zero,
          ),
          const SizedBox(height: 12),
          Obx(() => Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: Text('all'.tr),
                  selected: controller.selectedType.value == null,
                  onSelected: (selected) {
                    if (selected) {
                      controller.selectedType.value = null;
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ChoiceChip(
                  label: Text('expense'.tr),
                  selected: controller.selectedType.value == TransactionType.expense,
                  onSelected: (selected) {
                    if (selected) {
                      controller.selectedType.value = TransactionType.expense;
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ChoiceChip(
                  label: Text('income'.tr),
                  selected: controller.selectedType.value == TransactionType.income,
                  onSelected: (selected) {
                    if (selected) {
                      controller.selectedType.value = TransactionType.income;
                    }
                  },
                ),
              ),
            ],
          )),
          const SizedBox(height: 24),

          // Sort By
          SectionHeader(
            title: 'sort_by'.tr,
            padding: EdgeInsets.zero,
          ),
          const SizedBox(height: 12),
          Obx(() => Column(
            children: SortBy.values.map((sort) {
              return RadioListTile<SortBy>(
                title: Text(_getSortLabel(sort)),
                value: sort,
                groupValue: controller.sortBy.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.sortBy.value = value;
                  }
                },
                contentPadding: EdgeInsets.zero,
              );
            }).toList(),
          )),
          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'clear_all'.tr,
                  onPressed: () {
                    controller.clearFilters();
                    Get.back();
                  },
                  isOutlined: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  text: 'apply'.tr,
                  onPressed: () => Get.back(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getPeriodLabel(FilterPeriod period) {
    switch (period) {
      case FilterPeriod.all:
        return 'all'.tr;
      case FilterPeriod.today:
        return 'today'.tr;
      case FilterPeriod.week:
        return 'this_week'.tr;
      case FilterPeriod.month:
        return 'this_month'.tr;
      case FilterPeriod.custom:
        return 'custom'.tr;
    }
  }

  String _getSortLabel(SortBy sort) {
    switch (sort) {
      case SortBy.dateNewest:
        return 'date_newest'.tr;
      case SortBy.dateOldest:
        return 'date_oldest'.tr;
      case SortBy.amountHighest:
        return 'amount_highest'.tr;
      case SortBy.amountLowest:
        return 'amount_lowest'.tr;
      case SortBy.category:
        return 'category'.tr;
    }
  }
}
