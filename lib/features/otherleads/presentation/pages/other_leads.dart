import 'package:cars_right/features/dashboard/leads/presentation/widgets/lead_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtherLeadsScreen extends ConsumerStatefulWidget {
  final VoidCallback? onLeadPicked;
  const OtherLeadsScreen({super.key, this.onLeadPicked});

  @override
  ConsumerState<OtherLeadsScreen> createState() => _OtherLeadsScreenState();
}

class _OtherLeadsScreenState extends ConsumerState<OtherLeadsScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<String> selectedPriorities = [];
  final List<String> priorities = ['High', 'Medium', 'Low'];

  final List<Map<String, dynamic>> leads = [
    {
      'vehicle': 'Maruti Swift Dzire VXI',
      'regNo': 'TN09AB1234',
      'priority': 'High',
      'location': 'Velachery, Chennai',
      'distance': '2.4 km away',
      'time': '12 mins ago',
      'customer': 'Raj Kumar',
      'mobile': '+91 9876543210',
    },
    {
      'vehicle': 'Hyundai i20 Sportz',
      'regNo': 'TN10CD4567',
      'priority': 'Medium',
      'location': 'Guindy, Chennai',
      'distance': '4.1 km away',
      'time': '18 mins ago',
      'customer': 'Prakash',
      'mobile': '+91 9123456780',
    },
    {
      'vehicle': 'Honda City VX',
      'regNo': 'TN22EF8899',
      'priority': 'Low',
      'location': 'Tambaram, Chennai',
      'distance': '8.6 km away',
      'time': '25 mins ago',
      'customer': 'Arun Kumar',
      'mobile': '+91 9988776655',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredLeads {
    if (selectedPriorities.isEmpty) return leads;

    return leads.where((lead) {
      return selectedPriorities.contains(lead['priority']);
    }).toList();
  }

  void _pickLead(Map<String, dynamic> lead) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${lead['vehicle']} picked successfully'),
        backgroundColor: const Color(0xFF8028F0),
      ),
    );
    widget.onLeadPicked?.call();
  }

  @override
  Widget build(BuildContext context) {
    final visibleLeads = filteredLeads;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Row(
              children: [
                Expanded(
                  child: LeadSearchBar(
                    hinttext: 'Search vehicle, customer, reg no',
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 8),
                _priorityFilterButton(),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              '${visibleLeads.length} nearby leads available',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: visibleLeads.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _leadCard(visibleLeads[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _priorityFilterButton() {
    return PopupMenuButton<String>(
      offset: const Offset(0, 45),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      icon: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: const Icon(Icons.tune_rounded),
      ),
      itemBuilder: (context) {
        return priorities.map((priority) {
          final isSelected = selectedPriorities.contains(priority);

          return PopupMenuItem<String>(
            value: priority,
            child: Row(
              children: [
                Checkbox(
                  value: isSelected,
                  activeColor: const Color(0xFF8028F0),
                  onChanged: (_) {
                    setState(() {
                      if (isSelected) {
                        selectedPriorities.remove(priority);
                      } else {
                        selectedPriorities.add(priority);
                      }
                    });

                    Navigator.pop(context);
                  },
                ),
                Text(
                  priority,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }).toList();
      },
    );
  }

  Widget _leadCard(Map<String, dynamic> lead) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8EAF0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFEEEBFF),
                child: Icon(
                  Icons.directions_car_filled_rounded,
                  color: Color(0xFF8028F0),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lead['vehicle'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      lead['regNo'],
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              _stsContainer(lead['priority']),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 18, color: Colors.red),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  lead['location'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.route_outlined,
                  size: 17, color: Color(0xFF064F86)),
              const SizedBox(width: 6),
              Text(
                lead['distance'],
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              const Icon(Icons.access_time_rounded,
                  size: 17, color: Colors.orange),
              const SizedBox(width: 5),
              Text(
                lead['time'],
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            children: [
              const Icon(Icons.person_outline_rounded,
                  size: 18, color: Colors.grey),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  lead['customer'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Icon(Icons.phone_outlined, size: 17, color: Colors.grey),
              const SizedBox(width: 5),
              Text(
                lead['mobile'],
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _pickLead(lead),
              icon: const Icon(Icons.handshake_outlined, size: 19),
              label: const Text('Pick My Lead'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8028F0),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stsContainer(String text) {
    Color color;

    if (text == 'High') {
      color = Colors.red;
    } else if (text == 'Medium') {
      color = Colors.orange;
    } else {
      color = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(.13),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(.7)),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
