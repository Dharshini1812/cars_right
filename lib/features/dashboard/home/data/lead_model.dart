class LeadModel {
  final String vehicleName;
  final String regNo;
  final String location;
  final String customerName;
  final String time;
  final String phone;
  final String priority;
  final String address;
  final bool isScheduled;
  final bool isPickedUp;
  final String? scheduledDateTime;

  LeadModel({
    required this.vehicleName,
    required this.regNo,
    required this.location,
    required this.customerName,
    required this.time,
    required this.phone,
    required this.priority,
    required this.address,
    this.isScheduled = false,
    this.isPickedUp = false,
    this.scheduledDateTime,
  });

  LeadModel copyWith({
    bool? isScheduled,
    bool? isPickedUp,
    String? scheduledDateTime,
  }) {
    return LeadModel(
      vehicleName: vehicleName,
      regNo: regNo,
      location: location,
      customerName: customerName,
      time: time,
      phone: phone,
      priority: priority,
      address: address,
      isScheduled: isScheduled ?? this.isScheduled,
      isPickedUp: isPickedUp ?? this.isPickedUp,
      scheduledDateTime: scheduledDateTime ?? this.scheduledDateTime,
    );
  }
}
