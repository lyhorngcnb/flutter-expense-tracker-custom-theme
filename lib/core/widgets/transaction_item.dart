// ==================== 3. WIDGET: transaction_item.dart ====================
import 'package:expensetracker/features/transaction/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:expensetracker/core/widgets/custom_card.dart';
import 'package:expensetracker/core/widgets/badge_widget.dart';
import 'package:get/get.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.onTap,
    this.onDelete,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(transaction.id),
      background: _buildSwipeBackground(context, Alignment.centerLeft, Colors.blue, Icons.edit),
      secondaryBackground: _buildSwipeBackground(context, Alignment.centerRight, Colors.red, Icons.delete),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          // Delete
          return await _showDeleteConfirmation(context);
        } else {
          // Edit
          onEdit?.call();
          return false;
        }
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDelete?.call();
        }
      },
      child: CustomCard(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        onTap: onTap,
        child: Row(
          children: [
            // Category Icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getCategoryColor().withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getCategoryIcon(),
                color: _getCategoryColor(),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Transaction Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          transaction.description,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (transaction.isRecurring)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Icon(
                            Icons.repeat,
                            size: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      BadgeWidget(
                        text: transaction.category,
                        backgroundColor: _getCategoryColor().withOpacity(0.1),
                        textColor: _getCategoryColor(),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatTime(transaction.date),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Amount
            Text(
              '${transaction.type == TransactionType.expense ? '-' : '+'}\$${transaction.amount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: transaction.type == TransactionType.expense
                    ? Colors.red
                    : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwipeBackground(BuildContext context, Alignment alignment, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Icon(icon, color: Colors.white),
    );
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('delete_transaction'.tr),
        content: Text('delete_confirmation'.tr),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('cancel'.tr),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text('delete'.tr),
          ),
        ],
      ),
    ) ?? false;
  }

  Color _getCategoryColor() {
    switch (transaction.category.toLowerCase()) {
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

  IconData _getCategoryIcon() {
    switch (transaction.category.toLowerCase()) {
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

  String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
