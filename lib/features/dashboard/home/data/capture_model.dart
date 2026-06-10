class CapturedModel {
  final String imagePath;
  final double? latitude;
  final double? longitude;
  final DateTime capturedAt;

  CapturedModel({
    required this.imagePath,
    required this.latitude,
    required this.longitude,
    required this.capturedAt,
  });
}
