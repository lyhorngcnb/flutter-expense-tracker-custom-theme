// ==================== 2. CONTROLLER: transaction_controller.dart ====================
import 'package:expensetracker/features/transaction/models/transaction_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TransactionController extends GetxController {
  // Observable lists
  var transactions = <TransactionModel>[].obs;
  var filteredTransactions = <TransactionModel>[].obs;

  // Loading states
  var isLoading = false.obs;
  var isDeleting = false.obs;

  // Search and filters
  var searchQuery = ''.obs;
  var selectedCategory = Rx<String?>(null);
  var selectedType = Rx<TransactionType?>(null);
  var sortBy = SortBy.dateNewest.obs;
  var filterPeriod = FilterPeriod.all.obs;
  var customStartDate = Rx<DateTime?>(null);
  var customEndDate = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    loadTransactions();

    // Listen to search and filter changes
    ever(searchQuery, (_) => applyFilters());
    ever(selectedCategory, (_) => applyFilters());
    ever(selectedType, (_) => applyFilters());
    ever(sortBy, (_) => applyFilters());
    ever(filterPeriod, (_) => applyFilters());
  }

  // Load transactions from API/Database
  Future<void> loadTransactions() async {
    isLoading.value = true;
    try {
      // TODO: Replace with actual API call
      await Future.delayed(Duration(seconds: 1));

      // Demo data
      transactions.value = _generateDemoData();
      applyFilters();
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failed_to_load_transactions'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Apply filters and search
  void applyFilters() {
    var result = transactions.toList();

    // Search filter
    if (searchQuery.value.isNotEmpty) {
      result = result.where((t) =>
      t.description.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          t.category.toLowerCase().contains(searchQuery.value.toLowerCase())
      ).toList();
    }

    // Category filter
    if (selectedCategory.value != null) {
      result = result.where((t) => t.category == selectedCategory.value).toList();
    }

    // Type filter
    if (selectedType.value != null) {
      result = result.where((t) => t.type == selectedType.value).toList();
    }

    // Period filter
    result = _filterByPeriod(result);

    // Sort
    result = _sortTransactions(result);

    filteredTransactions.value = result;
  }

  List<TransactionModel> _filterByPeriod(List<TransactionModel> list) {
    final now = DateTime.now();

    switch (filterPeriod.value) {
      case FilterPeriod.today:
        return list.where((t) =>
        t.date.year == now.year &&
            t.date.month == now.month &&
            t.date.day == now.day
        ).toList();

      case FilterPeriod.week:
        final weekAgo = now.subtract(Duration(days: 7));
        return list.where((t) => t.date.isAfter(weekAgo)).toList();

      case FilterPeriod.month:
        return list.where((t) =>
        t.date.year == now.year &&
            t.date.month == now.month
        ).toList();

      case FilterPeriod.custom:
        if (customStartDate.value != null && customEndDate.value != null) {
          return list.where((t) =>
          t.date.isAfter(customStartDate.value!) &&
              t.date.isBefore(customEndDate.value!.add(Duration(days: 1)))
          ).toList();
        }
        return list;

      case FilterPeriod.all:
      default:
        return list;
    }
  }

  List<TransactionModel> _sortTransactions(List<TransactionModel> list) {
    switch (sortBy.value) {
      case SortBy.dateNewest:
        list.sort((a, b) => b.date.compareTo(a.date));
        break;
      case SortBy.dateOldest:
        list.sort((a, b) => a.date.compareTo(b.date));
        break;
      case SortBy.amountHighest:
        list.sort((a, b) => b.amount.compareTo(a.amount));
        break;
      case SortBy.amountLowest:
        list.sort((a, b) => a.amount.compareTo(b.amount));
        break;
      case SortBy.category:
        list.sort((a, b) => a.category.compareTo(b.category));
        break;
    }
    return list;
  }

  // Get transaction by ID
  TransactionModel? getTransactionById(String id) {
    try {
      return transactions.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }

  // Delete transaction
  Future<void> deleteTransaction(String id) async {
    isDeleting.value = true;
    try {
      // TODO: Replace with actual API call
      await Future.delayed(Duration(milliseconds: 500));

      transactions.removeWhere((t) => t.id == id);
      applyFilters();

      Get.snackbar(
        'success'.tr,
        'transaction_deleted'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failed_to_delete'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isDeleting.value = false;
    }
  }

  // Update transaction
  Future<void> updateTransaction(TransactionModel transaction) async {
    isLoading.value = true;
    try {
      // TODO: Replace with actual API call
      await Future.delayed(Duration(milliseconds: 500));

      final index = transactions.indexWhere((t) => t.id == transaction.id);
      if (index != -1) {
        transactions[index] = transaction;
        applyFilters();
      }

      Get.back();
      Get.snackbar(
        'success'.tr,
        'transaction_updated'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failed_to_update'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Clear filters
  void clearFilters() {
    searchQuery.value = '';
    selectedCategory.value = null;
    selectedType.value = null;
    filterPeriod.value = FilterPeriod.all;
    customStartDate.value = null;
    customEndDate.value = null;
    sortBy.value = SortBy.dateNewest;
  }

  // Group transactions by date
  Map<String, List<TransactionModel>> get groupedTransactions {
    final Map<String, List<TransactionModel>> grouped = {};

    for (var transaction in filteredTransactions) {
      final dateKey = _getDateGroupKey(transaction.date);
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(transaction);
    }

    return grouped;
  }

  String _getDateGroupKey(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final transactionDate = DateTime(date.year, date.month, date.day);

    if (transactionDate == today) {
      return 'today'.tr;
    } else if (transactionDate == yesterday) {
      return 'yesterday'.tr;
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  // Calculate total for filtered transactions
  // double get totalExpense {
  //   return filteredTransactions
  //       .where((t) => t.type == TransactionType.expense)
  //       .fold(0, (sum, t) => sum + t.amount);
  // }
  double get totalExpense {
    return filteredTransactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get totalIncome {
    return filteredTransactions
        .where((t) => t.type == TransactionType.income)
        .fold(0, (sum, t) => sum + t.amount);
  }

  // Demo data generator
  List<TransactionModel> _generateDemoData() {
    final now = DateTime.now();
    return [
      TransactionModel(
        id: '1',
        amount: 45.50,
        category: 'Food',
        description: 'Lunch at Restaurant',
        date: now,
        type: TransactionType.expense,
        note: 'Had lunch with friends',
      ),
      TransactionModel(
        id: '2',
        amount: 320.00,
        category: 'Salary',
        description: 'Monthly Salary',
        date: now.subtract(Duration(days: 1)),
        type: TransactionType.income,
      ),
      TransactionModel(
        id: '3',
        amount: 28.50,
        category: 'Transport',
        description: 'Gas Station',
        date: now.subtract(Duration(days: 2)),
        type: TransactionType.expense,
      ),
      TransactionModel(
        id: '4',
        amount: 15.00,
        category: 'Entertainment',
        description: 'Cinema Tickets',
        date: now.subtract(Duration(days: 3)),
        type: TransactionType.expense,
      ),
      TransactionModel(
        id: '5',
        amount: 50.00,
        category: 'Health',
        description: 'Gym Membership',
        date: now.subtract(Duration(days: 5)),
        type: TransactionType.expense,
        isRecurring: true,
      ),
      TransactionModel(
        id: '6',
        amount: 120.00,
        category: 'Shopping',
        description: 'Grocery Shopping',
        date: now.subtract(Duration(days: 7)),
        type: TransactionType.expense,
      ),
      TransactionModel(
        id: '7',
        amount: 200.00,
        category: 'Freelance',
        description: 'Website Project',
        date: now.subtract(Duration(days: 10)),
        type: TransactionType.income,
      ),
    ];
  }
}