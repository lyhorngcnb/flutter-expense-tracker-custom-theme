class TransactionModel {
  final String id;
  final double amount;
  final String category;
  final String description;
  final DateTime date;
  final String? note;
  final TransactionType type;
  final bool isRecurring;
  final String? receiptUrl;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.description,
    required this.date,
    this.note,
    required this.type,
    this.isRecurring = false,
    this.receiptUrl,
  });

  // From JSON
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      note: json['note'],
      type: json['type'] == 'income' ? TransactionType.income : TransactionType.expense,
      isRecurring: json['isRecurring'] ?? false,
      receiptUrl: json['receiptUrl'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'description': description,
      'date': date.toIso8601String(),
      'note': note,
      'type': type == TransactionType.income ? 'income' : 'expense',
      'isRecurring': isRecurring,
      'receiptUrl': receiptUrl,
    };
  }

  // Copy with
  TransactionModel copyWith({
    String? id,
    double? amount,
    String? category,
    String? description,
    DateTime? date,
    String? note,
    TransactionType? type,
    bool? isRecurring,
    String? receiptUrl,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
      note: note ?? this.note,
      type: type ?? this.type,
      isRecurring: isRecurring ?? this.isRecurring,
      receiptUrl: receiptUrl ?? this.receiptUrl,
    );
  }
}

enum TransactionType {
  expense,
  income,
}

enum SortBy {
  dateNewest,
  dateOldest,
  amountHighest,
  amountLowest,
  category,
}

enum FilterPeriod {
  all,
  today,
  week,
  month,
  custom,
}