
// ==================== ADD EXPENSE SCREEN ====================

import 'dart:developer';

import 'package:expensetracker/core/widgets/amount_input.dart';
import 'package:expensetracker/core/widgets/category_selector.dart';
import 'package:expensetracker/core/widgets/date_time_picker.dart' show DateTimePicker;
import 'package:expensetracker/features/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expensetracker/core/widgets/custom_text_field.dart';
import 'package:expensetracker/core/widgets/custom_button.dart';
import 'package:expensetracker/core/widgets/custom_app_bar.dart';
import 'package:expensetracker/core/widgets/section_header.dart';
import 'package:expensetracker/core/widgets/custom_snackbar.dart';

class AddExpenseView extends StatefulWidget {
  const AddExpenseView({Key? key}) : super(key: key);

  @override
  State<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _noteController = TextEditingController();

  String? _selectedCategory;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isRecurring = false;

  final List<CategoryItem> _categories = [
    CategoryItem(name: 'Food', icon: Icons.restaurant, color: Colors.orange),
    CategoryItem(name: 'Shopping', icon: Icons.shopping_bag, color: Colors.pink),
    CategoryItem(name: 'Transport', icon: Icons.directions_car, color: Colors.blue),
    CategoryItem(name: 'Entertainment', icon: Icons.movie, color: Colors.purple),
    CategoryItem(name: 'Health', icon: Icons.local_hospital, color: Colors.red),
    CategoryItem(name: 'Bills', icon: Icons.receipt, color: Colors.teal),
    CategoryItem(name: 'Education', icon: Icons.school, color: Colors.indigo),
    CategoryItem(name: 'Others', icon: Icons.more_horiz, color: Colors.grey),
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'add_expense'.tr,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Get.off(() => HomeView()),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Amount Input
              AmountInput(
                controller: _amountController,
                currency: '\$',
              ),
              const SizedBox(height: 24),

              // Category Selection
              SectionHeader(
                title: 'category'.tr,
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: 12),
              CategorySelector(
                categories: _categories,
                selectedCategory: _selectedCategory,
                onCategorySelected: (category) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Description
              SectionHeader(
                title: 'description'.tr,
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _descriptionController,
                hint: 'enter_description'.tr,
                prefixIcon: Icons.edit_note,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'description_required'.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Date and Time
              SectionHeader(
                title: 'date_time'.tr,
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: 12),
              DateTimePicker(
                selectedDate: _selectedDate,
                selectedTime: _selectedTime,
                onDateChanged: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
                onTimeChanged: (time) {
                  setState(() {
                    _selectedTime = time;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Notes (Optional)
              SectionHeader(
                title: 'notes_optional'.tr,
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _noteController,
                hint: 'add_notes'.tr,
                prefixIcon: Icons.notes,
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // Recurring Expense Toggle
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.repeat,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'recurring_expense'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'repeat_monthly'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _isRecurring,
                      onChanged: (value) {
                        setState(() {
                          _isRecurring = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'cancel'.tr,
                      onPressed: () => Get.back(),
                      isOutlined: true,
                      height: 56,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      text: 'save_expense'.tr,
                      onPressed: _saveExpense,
                      icon: Icons.check,
                      height: 56,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _saveExpense() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategory == null) {
        CustomSnackbar.showError(context, 'please_select_category'.tr);
        return;
      }

      if (_amountController.text.isEmpty) {
        CustomSnackbar.showError(context, 'please_enter_amount'.tr);
        return;
      }

      // TODO: Save expense to database/API
      final expense = {
        'amount': double.parse(_amountController.text),
        'category': _selectedCategory,
        'description': _descriptionController.text,
        'date': _selectedDate,
        'time': _selectedTime,
        'note': _noteController.text,
        'isRecurring': _isRecurring,
      };

      print('Saving expense: $expense');

      // Show success message
      CustomSnackbar.showSuccess(context, 'expense_saved_successfully'.tr);

      // Navigate back
      Future.delayed(Duration(milliseconds: 500), () {
        Get.back();
      });
    }
  }
}