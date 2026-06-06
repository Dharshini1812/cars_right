import 'package:cars_right/core/theme/app_theme.dart';
import 'package:cars_right/core/widgets/succes.dart';
import 'package:cars_right/features/dashboard/home/data/lead_model.dart';
import 'package:cars_right/features/dashboard/home/presentation/pages/leads/lead_details_page.dart';
import 'package:cars_right/features/dashboard/home/presentation/widgets/home/leads/lead_card.dart';
import 'package:cars_right/features/dashboard/home/presentation/widgets/home/leads/lead_filter_card.dart';
import 'package:cars_right/features/dashboard/home/presentation/widgets/home/leads/lead_search_bar.dart';
import 'package:cars_right/features/dashboard/home/presentation/widgets/home/leads/schedule_bottom_sheet.dart';
import 'package:flutter/material.dart';

class LeadsScreen extends StatefulWidget {
  const LeadsScreen({super.key});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  DateTime? fromDate;
  DateTime? toDate;
  String selectedPriority = 'All';

  Future<void> _pickFromDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: fromDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        fromDate = picked;

        if (toDate != null && toDate!.isBefore(fromDate!)) {
          toDate = null;
        }
      });
    }
  }

  Future<void> _pickToDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: toDate ?? fromDate ?? DateTime.now(),
      firstDate: fromDate ?? DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        toDate = picked;
      });
    }
  }

  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  bool showSuccess = false;
  String successTitle = '';
  String successSubtitle = '';

  List<LeadModel> get filteredLeads {
    if (searchQuery.trim().isEmpty) return leads;

    final query = searchQuery.toLowerCase();

    return leads.where((lead) {
      return lead.vehicleName.toLowerCase().contains(query) ||
          lead.regNo.toLowerCase().contains(query) ||
          lead.customerName.toLowerCase().contains(query) ||
          lead.location.toLowerCase().contains(query) ||
          lead.phone.toLowerCase().contains(query);
    }).toList();
  }

  List<LeadModel> leads = [
    LeadModel(
      vehicleName: 'Maruti Swift Dzire',
      regNo: 'TN 09 AB 1234',
      location: 'T.Nagar',
      customerName: 'Ravi Shankar',
      time: 'Today 11:00 AM',
      phone: '+91 98405 44120',
      priority: 'High',
      address: 'No. 18, South Usman Road, T.Nagar, Chennai',
    ),
    LeadModel(
      vehicleName: 'Honda Activa 6G',
      regNo: 'TN 22 GH 5566',
      location: 'Velachery',
      customerName: 'Priya Devi',
      time: 'Today 02:30 PM',
      phone: '+91 98840 22115',
      priority: 'Medium',
      address: '52, 100 Feet Bypass Road, Velachery, Chennai',
    ),
    LeadModel(
      vehicleName: 'Mahindra Bolero Pickup',
      regNo: 'TN 07 CD 8899',
      location: 'Porur',
      customerName: 'Karthik',
      time: 'Today 04:00 PM',
      phone: '+91 97908 66443',
      priority: 'Low',
      address: 'Porur Main Road, Chennai',
    ),
  ];

  void _openScheduleSheet(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return ScheduleLeadBottomSheet(
          lead: leads[index],
          onSave: () async {
            Navigator.pop(context);

            setState(() {
              leads[index] = leads[index].copyWith(
                isScheduled: true,
                scheduledDateTime: '06 Jun 2026 10:00',
              );

              successTitle = 'Scheduled';
              successSubtitle = 'Lead pickup confirmed';
              showSuccess = true;
            });

            await Future.delayed(const Duration(seconds: 2));

            if (!mounted) return;

            setState(() {
              showSuccess = false;
            });
          },
        );
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _handlePickup(int index) async {
      setState(() {
        leads[index] = leads[index].copyWith(
          isPickedUp: true,
        );

        successTitle = 'Picked up';
        successSubtitle = 'Lead pickup confirmed';
        showSuccess = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      setState(() {
        showSuccess = false;
      });

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => LeadDetailsBottomSheet(
          lead: leads[index],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  const SizedBox(height: 18),
                  LeadSearchBar(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  LeadFilterCard(
                    fromDate: fromDate,
                    toDate: toDate,
                    selectedPriority: selectedPriority,
                    onFromTap: _pickFromDate,
                    onToTap: _pickToDate,
                    onPriorityChanged: (value) {
                      setState(() {
                        selectedPriority = value;
                      });
                    },
                  ),
                  const SizedBox(height: 18),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredLeads.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final lead = filteredLeads[index];

                      final originalIndex = leads.indexOf(lead);

                      return LeadCard(
                        lead: lead,
                        onScheduleTap: () => _openScheduleSheet(originalIndex),
                        onPickupTap: lead.isScheduled
                            ? () {
                                if (lead.isPickedUp) {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (_) => LeadDetailsBottomSheet(
                                      lead: leads[originalIndex],
                                    ),
                                  );
                                } else {
                                  _handlePickup(originalIndex);
                                }
                              }
                            : null,
                      );
                    },
                  ),
                ],
              ),
            ),
            if (showSuccess)
              SuccessOverlay(
                title: successTitle,
                subtitle: successSubtitle,
              ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'New Leads',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        Text(
          '3 pending pickup',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF667085),
          ),
        ),
      ],
    );
  }
}
