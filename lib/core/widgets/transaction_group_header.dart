// ==================== 5. WIDGET: transaction_group_header.dart ====================
import 'package:flutter/material.dart';

class TransactionGroupHeader extends StatelessWidget {
  final String title;
  final double totalAmount;
  final bool isExpense;

  const TransactionGroupHeader({
    Key? key,
    required this.title,
    required this.totalAmount,
    this.isExpense = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          Text(
            '\$${totalAmount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isExpense ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}