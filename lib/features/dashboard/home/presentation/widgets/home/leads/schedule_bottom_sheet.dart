import 'package:cars_right/core/theme/app_theme.dart';
import 'package:cars_right/features/dashboard/home/data/lead_model.dart';
import 'package:flutter/material.dart';

class ScheduleLeadBottomSheet extends StatelessWidget {
  final LeadModel lead;
  final VoidCallback onSave;

  const ScheduleLeadBottomSheet({
    super.key,
    required this.lead,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 22,
        right: 22,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dragHandle(),
          const SizedBox(height: 28),
          const Text(
            'Schedule Lead',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            lead.vehicleName,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF667085),
            ),
          ),
          const SizedBox(height: 22),
          const Text('LOCATION', style: _labelStyle),
          const SizedBox(height: 10),
          _inputBox(text: lead.address),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _fieldWithLabel(
                  label: 'DATE',
                  text: '06/06/2026',
                  icon: Icons.calendar_today_outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _fieldWithLabel(
                  label: 'TIME',
                  text: '10:00 AM',
                  icon: Icons.access_time,
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          _saveButton(),
          const SizedBox(height: 14),
          _cancelButton(context),
        ],
      ),
    );
  }

  static const _labelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    color: Color(0xFF344054),
  );

  Widget _dragHandle() {
    return Center(
      child: Container(
        width: 42,
        height: 5,
        decoration: BoxDecoration(
          color: const Color(0xFFD4DEE8),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _fieldWithLabel({
    required String label,
    required String text,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: _labelStyle),
        const SizedBox(height: 10),
        _inputBox(text: text, icon: icon),
      ],
    );
  }

  Widget _inputBox({
    required String text,
    IconData? icon,
  }) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD4E2F0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
          if (icon != null) Icon(icon, size: 19),
        ],
      ),
    );
  }

  Widget _saveButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: onSave,
        icon: const Icon(Icons.event_available, size: 19),
        label: const Text(
          'Save Schedule',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  Widget _cancelButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: () => Navigator.pop(context),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFD4E2F0)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'Cancel',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
