import 'package:cars_right/features/onboarding/data/model/onboarding_model.dart';

class OnboardingData {
  static const List<OnboardingModel> pages = [
    OnboardingModel(
        imagePath: 'images/onboarding/img1.jpg',
        badge: 'Vehicle Inspection & Valuation',
        badgeEmoji: '🚗',
        title: 'Complete Vehicle\nInspection',
        description:
            'Capture full inspection details from customer \nverification to vehicle condition, photos, and \nvaluation',
        imageTopWord: 'Complete vehicle inspection'),
    OnboardingModel(
        imagePath: 'images/onboarding/img2.webp',
        badge: 'Instant Market Price',
        badgeEmoji: '🚗',
        title: 'Photo Proof For Every\nCase',
        description:
            'Guide valuators through tyre, body, interior,\nodometer, RC, and damage photo capture with clean \ncheckpoints',
        imageTopWord: 'Tyre,body and photo proof'),
    OnboardingModel(
        imagePath: 'images/onboarding/img3.webp',
        badge: 'Detailed Reports',
        badgeEmoji: '🚗',
        title: 'Engine Checks and\nReports',
        description:
            'Record mechanical condition, document status,\nremarks, and generate mobile-ready CarsRight \ninspection reports.',
        imageTopWord: 'Engine and document checks'),
  ];
}
