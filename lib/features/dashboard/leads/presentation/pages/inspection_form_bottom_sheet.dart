import 'package:cars_right/core/theme/app_theme.dart';
import 'package:cars_right/features/dashboard/home/data/lead_model.dart';
import 'package:cars_right/features/dashboard/leads/presentation/widgets/mandatory_photos_card.dart';
import 'package:cars_right/features/dashboard/leads/presentation/widgets/rating_row.dart';
import 'package:cars_right/features/dashboard/leads/presentation/widgets/valuation_summary_card.dart';
import 'package:flutter/material.dart';

class InspectionFormBottomSheet extends StatelessWidget {
  final LeadModel lead;

  const InspectionFormBottomSheet({
    super.key,
    required this.lead,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      minChildSize: 0.70,
      maxChildSize: 0.94,
      expand: false,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(34),
          ),
          child: Container(
            color: const Color(0xFFEFF5FA),
            child: InspectionFormView(
              lead: lead,
              // scrollController: scrollController,
              // onBack: () => Navigator.pop(context),
            ),
          ),
        );
      },
    );
  }
}

class InspectionFormView extends StatefulWidget {
  final LeadModel lead;

  const InspectionFormView({
    super.key,
    required this.lead,
  });

  @override
  State<InspectionFormView> createState() => _InspectionFormViewState();
}

class _InspectionFormViewState extends State<InspectionFormView> {
  String selectedTab = '2W';

  final tabs = ['2W', '4W', 'CV', 'CE', 'FE'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _fixedHeader(),
        Expanded(
          child: SingleChildScrollView(
            // controller: widget.scrollController,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _tabBar(),
                const SizedBox(height: 18),
                _leadVehicleDetailsCard(),
                const SizedBox(height: 18),
                _documentVerificationCard(),
                const SizedBox(height: 18),
                _conditionSection(
                  title: 'Exterior Body & Paint',
                  items: [
                    'Front Bonnet',
                    'Front Bumper',
                    'Head Lamps',
                    'RH Fender & Doors',
                    'Rear Bumper',
                    'LH Fender & Doors',
                    'Windshield & Glass',
                    'Paint Condition',
                  ],
                ),
                const SizedBox(height: 18),
                _conditionSection(
                  title: 'Interior',
                  items: [
                    'Steering',
                    'Dashboard',
                    'Interior Trims',
                    'Seats Condition',
                    'AC / Heater',
                    'Infotainment',
                  ],
                ),
                const SizedBox(height: 18),
                _conditionSection(
                  title: 'Engine, Chassis & Mechanical',
                  items: [
                    'Battery Condition',
                    'Engine Condition',
                    'Engine Function',
                    'Transmission Condition',
                    'Chassis & Frame',
                    'Suspension',
                    'Brakes',
                    'Ignition & Fuel System',
                  ],
                ),
                const SizedBox(height: 18),
                const MandatoryPhotosCard(),
                const SizedBox(height: 18),
                const ValuationSummaryCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _fixedHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFFEAF2FA),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              '2W Inspection Form\n${widget.lead.vehicleName} - ${widget.lead.regNo}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBar() {
    return Row(
      children: tabs.map((tab) {
        final selected = selectedTab == tab;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedTab = tab;
                });
              },
              child: Container(
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFDDE7F0)),
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: selected ? Colors.white : AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _conditionSection({
    required String title,
    required List<String> items,
  }) {
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: RatingRow(title: item),
            );
          }),
        ],
      ),
    );
  }

  Widget _leadVehicleDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lead & Vehicle Details',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          _detailField('Registration No', widget.lead.regNo),
          _detailField('Vehicle', widget.lead.vehicleName),
          _detailField('Vehicle Type', selectedTab),
          _detailField('Fuel / Transmission', 'Petrol / Manual'),
          _detailField('Odometer / Hours', '38,420 km'),
          _detailField('Chassis No', 'MAJAXXMRKAM*****'),
          _detailField('Engine No', 'DRB4A*****'),
        ],
      ),
    );
  }

  Widget _detailField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Color(0xFF667085),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFD4E2F0)),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Color(0xFF111827),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _documentVerificationCard() {
    final docs = [
      'RC available and matching chassis / engine number',
      'Insurance valid upto 14 May 2027',
      'PUC valid and verified',
      'Hypothecation endorsed to HDFC Bank',
      'Physical damage reported by customer',
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Document Verification',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          ...docs.asMap().entries.map((entry) {
            final checked = entry.key != 4;

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  Icon(
                    checked ? Icons.check_box : Icons.check_box_outline_blank,
                    color:
                        checked ? AppColors.primary : const Color(0xFF667085),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: const Color(0xFFDDE7F0)),
    );
  }
}
