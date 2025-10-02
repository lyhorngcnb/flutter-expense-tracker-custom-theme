// 3. date_time_picker.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateTimePicker extends StatelessWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final Function(DateTime) onDateChanged;
  final Function(TimeOfDay) onTimeChanged;

  const DateTimePicker({
    Key? key,
    required this.selectedDate,
    required this.selectedTime,
    required this.onDateChanged,
    required this.onTimeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildPickerTile(
            context,
            icon: Icons.calendar_today,
            label: 'date'.tr,
            value: _formatDate(selectedDate),
            onTap: () => _selectDate(context),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildPickerTile(
            context,
            icon: Icons.access_time,
            label: 'time'.tr,
            value: selectedTime.format(context),
            onTap: () => _selectTime(context),
          ),
        ),
      ],
    );
  }

  Widget _buildPickerTile(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      onDateChanged(picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      onTimeChanged(picked);
    }
  }
}