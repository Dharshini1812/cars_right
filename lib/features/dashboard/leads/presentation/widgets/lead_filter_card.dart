import 'package:cars_right/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class LeadFilterCard extends StatelessWidget {
  final bool? isComplete;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String selectedPriority;
  final VoidCallback onFromTap;
  final VoidCallback onToTap;
  final ValueChanged<String> onPriorityChanged;

  const LeadFilterCard({
    super.key,
    required this.fromDate,
    required this.toDate,
    required this.selectedPriority,
    required this.onFromTap,
    required this.onToTap,
    required this.onPriorityChanged,
    required this.isComplete,
  });

  String _formatDate(DateTime? date) {
    if (date == null) return 'dd/mm/yyyy';

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day/$month/$year';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFDDE7F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('DATE RANGE', style: _labelStyle),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _dateField(
                  label: 'From',
                  value: _formatDate(fromDate),
                  onTap: onFromTap,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _dateField(
                  label: 'To',
                  value: _formatDate(toDate),
                  onTap: onToTap,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text('PRIORITY', style: _labelStyle),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: isComplete == true
                ? [
                    _chip('All'),
                    _chip('Approved'),
                    _chip('Review'),
                  ]
                : [
                    _chip('All'),
                    _chip('High'),
                    _chip('Medium'),
                    _chip('Low'),
                  ],
          ),
        ],
      ),
    );
  }

  Widget _dateField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    final bool isSelected = value != 'dd/mm/yyyy';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF667085),
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected ? AppColors.primary : const Color(0xFFD4E2F0),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? AppColors.primary
                          : const Color(0xFF8A99AD),
                    ),
                  ),
                ),
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 17,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _chip(String text) {
    final bool selected = selectedPriority == text;

    return InkWell(
      onTap: () => onPriorityChanged(text),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFD4E2F0)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : const Color(0xFF344054),
          ),
        ),
      ),
    );
  }

  static const _labelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    color: Color(0xFF344054),
  );
}
