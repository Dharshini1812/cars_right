import 'package:cars_right/core/theme/app_theme.dart';
import 'package:cars_right/features/dashboard/home/data/lead_model.dart';
import 'package:flutter/material.dart';

class LeadCard extends StatelessWidget {
  final LeadModel lead;
  final VoidCallback onScheduleTap;
  final VoidCallback? onPickupTap;

  const LeadCard({
    super.key,
    required this.lead,
    required this.onScheduleTap,
    required this.onPickupTap,
  });

  @override
  Widget build(BuildContext context) {
    final pickupEnabled = onPickupTap != null;

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
          Row(
            children: [
              Expanded(child: _title()),
              _priorityBadge(),
            ],
          ),
          _regText(),
          const SizedBox(height: 16),
          _customerText(),
          const SizedBox(height: 14),
          Row(
            children: [
              _phoneChip(),
              const Spacer(),
              if (lead.isScheduled) _scheduledBadge(),
            ],
          ),
          if (lead.isScheduled) ...[
            const SizedBox(height: 16),
            _addressBox(),
          ],
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _button(
                  title: lead.isScheduled ? 'Reschedule' : 'Schedule',
                  icon: Icons.calendar_month,
                  enabled: true,
                  onTap: onScheduleTap,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _button(
                  title: lead.isPickedUp ? 'Picked Up' : 'Pick Up',
                  icon: lead.isPickedUp ? Icons.check : Icons.navigation,
                  enabled: pickupEnabled || lead.isPickedUp,
                  isGreen: lead.isPickedUp,
                  onTap: onPickupTap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return Text(
      lead.vehicleName,
      style: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
      ),
    );
  }

  Widget _regText() {
    return Text(
      '${lead.regNo} - ${lead.location}',
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF667085),
      ),
    );
  }

  Widget _customerText() {
    return Text(
      'Customer: ${lead.customerName} - ${lead.time}',
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Color(0xFF444444),
      ),
    );
  }

  Widget _priorityBadge() {
    final isHigh = lead.priority == 'High';
    final isMedium = lead.priority == 'Medium';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isHigh
            ? const Color(0xFFFFE8EC)
            : isMedium
                ? const Color(0xFFEAF2FA)
                : const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        lead.priority,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: isHigh
              ? const Color(0xFFD0132F)
              : isMedium
                  ? AppColors.primary
                  : const Color(0xFF555555),
        ),
      ),
    );
  }

  Widget _phoneChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: const Color(0xFFF5FAFF),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFD4E8FA)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 14,
            backgroundColor: AppColors.primary,
            child: Icon(Icons.call, color: Colors.white, size: 15),
          ),
          const SizedBox(width: 9),
          Text(
            lead.phone,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _scheduledBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F6EB),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        children: [
          Icon(Icons.event_available, size: 15, color: Color(0xFF147A43)),
          SizedBox(width: 5),
          Text(
            'Scheduled',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Color(0xFF147A43),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addressBox() {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FFF6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFBFE8D0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 13,
            backgroundColor: Color(0xFFD8F7E5),
            child: Icon(Icons.location_on, color: Color(0xFF147A43), size: 14),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${lead.address}\n',
                    style: const TextStyle(
                      color: Color(0xFF344054),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: lead.scheduledDateTime ?? '',
                    style: const TextStyle(
                      color: Color(0xFF147A43),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _button({
    required String title,
    required IconData icon,
    required bool enabled,
    required VoidCallback? onTap,
    bool isGreen = false,
  }) {
    return SizedBox(
      height: 50,
      child: ElevatedButton.icon(
        onPressed: enabled ? onTap : null,
        icon: Icon(icon, size: 18),
        label: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              isGreen ? const Color(0xFF18A84A) : AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFD7E2EC),
          disabledForegroundColor: const Color(0xFF7D8DA1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
