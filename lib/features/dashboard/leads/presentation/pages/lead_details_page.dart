import 'dart:async';
import 'dart:developer';

import 'package:cars_right/core/theme/app_theme.dart';
import 'package:cars_right/features/dashboard/leads/presentation/pages/inspection_form_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:cars_right/features/dashboard/home/data/lead_model.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class LeadDetailsBottomSheet extends ConsumerStatefulWidget {
  final LeadModel lead;

  const LeadDetailsBottomSheet({
    super.key,
    required this.lead,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LeadDetailsBottomSheetState();
}

class _LeadDetailsBottomSheetState
    extends ConsumerState<LeadDetailsBottomSheet> {
  LatLng customerLocation = const LatLng(13.0418, 80.2341);
  LatLng? currentLocation;
  double distanceInMeters = 999999;
  bool canStartInspection = false;
  StreamSubscription<Position>? positionStream;
  String? fetchedAddress;
  final MapController mapController = MapController();

  @override
  void initState() {
    _startLocationTracking();
    super.initState();
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

  Future<void> _startLocationTracking() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) async {
      print('LAT: ${position.latitude}');
      print('LNG: ${position.longitude}');
      final userLocation = LatLng(position.latitude, position.longitude);

      customerLocation = LatLng(
        position.latitude + 0.001,
        position.longitude + 0.001,
      );
      String address = 'Address not available';

      try {
        final placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          final place = placemarks.first;

          address = [
            place.name,
            place.street,
            place.subLocality,
            place.locality,
            place.administrativeArea,
          ].where((e) => e != null && e.isNotEmpty).join(', ');
        }
      } catch (e) {
        log('Address Error: $e');
      }
      final distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        customerLocation.latitude,
        customerLocation.longitude,
      );

      print('Distance = $distance');
      setState(() {
        currentLocation = userLocation;
        distanceInMeters = distance;
        fetchedAddress = address;
        canStartInspection = distance <= 200;
      });
      final center = LatLng(
        (userLocation.latitude + customerLocation.latitude) / 2,
        (userLocation.longitude + customerLocation.longitude) / 2,
      );

      mapController.move(center, 16);
    });
  }

  String get getDistance {
    if (currentLocation == null) return '-- km';
    final km = distanceInMeters / 1000;
    return '${km.toStringAsFixed(1)} km';
  }

  String get timeText {
    if (currentLocation == null) return '-- min';
    final km = distanceInMeters / 1000;
    const averageSpeedKmPerHour = 15;
    final minutes = (km / averageSpeedKmPerHour) * 60;
    return '${minutes.ceil()}min';
  }

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
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _acceptedCard(),
                      const SizedBox(height: 10),
                      _vehicleCard(),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: _infoCard(
                                  'CUSTOMER', widget.lead.customerName)),
                          const SizedBox(width: 8),
                          Expanded(
                              child: _infoCard('PHONE', widget.lead.phone)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: _infoCard('SCHEDULE', widget.lead.time)),
                          const SizedBox(width: 8),
                          Expanded(
                              child: _infoCard('AREA', widget.lead.location)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _locationCard(),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _bottomButton(
                              title: canStartInspection
                                  ? 'Start Inspection'
                                  : 'Reach Location First',
                              icon: Icons.assignment_turned_in,
                              filled: canStartInspection,
                              onTap: canStartInspection
                                  ? () {
                                      Navigator.pop(context);

                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (_) =>
                                            InspectionFormBottomSheet(
                                          lead: widget.lead,
                                        ),
                                      );
                                    }
                                  : null,
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
                  widget.lead.vehicleName,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  '${widget.lead.regNo} - ${widget.lead.priority}',
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
      padding: const EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _labelStyle),
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
            fetchedAddress ?? 'Fetching location',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 6),
          // const Text(
          //   'Opposite Phoenix Marketcity service gate',
          //   style: TextStyle(
          //     fontSize: 13,
          //     fontWeight: FontWeight.w700,
          //     color: Color(0xFF667085),
          //   ),
          // ),
          const SizedBox(height: 16),
          Text(
            currentLocation == null
                ? 'Fetching your current location...'
                : 'Distance: ${distanceInMeters.toStringAsFixed(0)} meters',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFF667085),
            ),
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              _mapPlaceholder(),
              Positioned(
                right: 4,
                bottom: 4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    '$getDistance - $timeText',
                    style: const TextStyle(
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _mapPlaceholder() {
    final LatLng mapCenter = currentLocation ?? customerLocation;

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: 220,
        child: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: mapCenter,
            initialZoom: 14,
            onTap: (tapPosition, point) async {
              log('map pressed');

              final Uri url = Uri.parse(
                'https://www.google.com/maps/dir/?api=1&destination=${customerLocation.latitude},${customerLocation.longitude}',
              );

              await launchUrl(
                url,
                mode: LaunchMode.externalApplication,
              );
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.cars_right',
            ),
            if (currentLocation != null)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [
                      currentLocation!,
                      customerLocation,
                    ],
                    strokeWidth: 4,
                    color: Colors.green,
                  ),
                ],
              ),
            MarkerLayer(
              markers: [
                Marker(
                  point: customerLocation,
                  width: 70,
                  height: 70,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF147A43),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                ),
                if (currentLocation != null)
                  Marker(
                    point: currentLocation!,
                    width: 70,
                    height: 70,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0E5B93),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      child: const Icon(
                        Icons.person_pin_circle,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomButton({
    required String title,
    required IconData icon,
    required bool filled,
    required VoidCallback? onTap,
  }) {
    return SizedBox(
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18),
        label: Text(
          title,
          style: const TextStyle(
            fontSize: 13,
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
