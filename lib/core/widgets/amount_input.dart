// 2. amount_input.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmountInput extends StatelessWidget {
  final TextEditingController controller;
  final String currency;

  const AmountInput({
    Key? key,
    required this.controller,
    this.currency = '\$',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'amount'.tr,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                currency,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  autofocus: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
