import 'package:cars_right/features/onboarding/data/model/onboarding_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/onboarding_data.dart';

// ── State ────────────────────────────────────────────────────────────────────

class OnboardingState {
  final int currentPage;
  final List<OnboardingModel> pages;

  const OnboardingState({
    required this.currentPage,
    required this.pages,
  });

  bool get isLastPage => currentPage == pages.length - 1;

  OnboardingState copyWith({int? currentPage}) => OnboardingState(
        currentPage: currentPage ?? this.currentPage,
        pages: pages,
      );
}

class OnboardingPage {
}

// ── Notifier ─────────────────────────────────────────────────────────────────

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  OnboardingNotifier()
      : super(const OnboardingState(
          currentPage: 0,
          pages: OnboardingData.pages,
        ));

  void setPage(int index) {
    if (index >= 0 && index < state.pages.length) {
      state = state.copyWith(currentPage: index);
    }
  }

  void nextPage() => setPage(state.currentPage + 1);
}

// ── Provider ─────────────────────────────────────────────────────────────────

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>(
  (_) => OnboardingNotifier(),
);