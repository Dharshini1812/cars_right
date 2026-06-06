import 'package:cars_right/core/theme/app_theme.dart';
import 'package:cars_right/features/dashboard/home/presentation/pages/leads/inspection_form_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:cars_right/features/dashboard/home/data/lead_model.dart';

class LeadDetailsBottomSheet extends StatelessWidget {
  final LeadModel lead;

  const LeadDetailsBottomSheet({
    super.key,
    required this.lead,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.75,
      maxChildSize: 0.96,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFEFF5FA),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(32),
            ),
          ),
          child: Column(
            children: [
              _header(context),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(22, 20, 22, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _acceptedCard(),
                      const SizedBox(height: 18),
                      _vehicleCard(),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                              child: _infoCard('CUSTOMER', lead.customerName)),
                          const SizedBox(width: 12),
                          Expanded(child: _infoCard('PHONE', lead.phone)),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(child: _infoCard('SCHEDULE', lead.time)),
                          const SizedBox(width: 12),
                          Expanded(child: _infoCard('AREA', lead.location)),
                        ],
                      ),
                      const SizedBox(height: 18),
                      _locationCard(),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            child: _bottomButton(
                              title: 'Start Inspection',
                              icon: Icons.assignment_turned_in,
                              filled: true,
                              onTap: () {
                                Navigator.pop(
                                    context); // close lead details bottom sheet

                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (_) => InspectionFormBottomSheet(
                                    lead: lead,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _bottomButton(
                                title: 'Add Photos',
                                icon: Icons.camera_alt,
                                filled: false,
                                onTap: () {}),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 15, bottom: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFFEAF2FA),
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lead Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Accepted and confirmed',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF667085),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _acceptedCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FFF6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFBFE8D0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xFFD8F7E5),
            ),
            child: const CircleAvatar(
              radius: 8,
              backgroundColor: Color(0xFF27AE60),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 12,
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lead accepted confirmed',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E293B),
                  ),
                ),
                Text(
                  'Map and inspection flow are ready',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF667085),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _vehicleCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          const Icon(Icons.directions_car, size: 25, color: Color(0xFF1E293B)),
          const SizedBox(width: 22),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '2W INSPECTION',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF667085),
                  ),
                ),
                Text(
                  lead.vehicleName,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  '${lead.regNo} - ${lead.priority}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF667085),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _labelStyle),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('LOCATION', style: _labelStyle),
          const SizedBox(height: 8),
          Text(
            lead.address,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Opposite Phoenix Marketcity service gate',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF667085),
            ),
          ),
          const SizedBox(height: 16),
          _mapPlaceholder(),
        ],
      ),
    );
  }

  Widget _mapPlaceholder() {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: const Color(0xFFDDEFFC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFBFD8EE)),
      ),
      child: const Center(
        child: CircleAvatar(
          radius: 38,
          backgroundColor: Color(0xFF147A43),
          child: Icon(
            Icons.location_on,
            color: Colors.white,
            size: 34,
          ),
        ),
      ),
    );
  }

  Widget _bottomButton({
    required String title,
    required IconData icon,
    required bool filled,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onTap,
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
          backgroundColor: filled ? AppColors.primary : Colors.white,
          foregroundColor: filled ? Colors.white : AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: Color(0xFFD4E2F0)),
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFFDDE7F0)),
    );
  }

  static const _labelStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w800,
    color: Color(0xFF667085),
  );
}
