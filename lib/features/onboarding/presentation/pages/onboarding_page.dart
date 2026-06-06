import 'dart:async';
import 'package:cars_right/features/onboarding/presentation/logic/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/onboarding_card.dart';
import '../widgets/page_dot_indicator.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  Timer? _autoPlayTimer;
  static const _autoPlayDuration = Duration(seconds: 3);
  static const _animDuration = Duration(milliseconds: 600);

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _stopAutoPlay();
    super.dispose();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(_autoPlayDuration, (_) {
      if (!mounted) return;
      final notifier = ref.read(onboardingProvider.notifier);
      final state = ref.read(onboardingProvider);
      if (state.isLastPage) {
        notifier.setPage(0);
      } else {
        notifier.nextPage();
      }
    });
  }

  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = null;
  }

  void _onGetStarted(OnboardingState state) {
    Navigator.pushReplacementNamed(context, '/onboarding-loader');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // ── Animated page content (crossfade) ──────────────────────────
          AnimatedSwitcher(
            duration: _animDuration,
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: _OnboardingPageContent(
              key: ValueKey(state.currentPage),
              page: state.pages[state.currentPage],
            ),
          ),

          // ── Bottom bar pinned at bottom ─────────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(
                  children: [
                    PageDotIndicator(
                      count: state.pages.length,
                      current: state.currentPage,
                    ),
                    const Spacer(),
                    _GetStartedButton(
                      label: 'Get Started',
                      onTap: () => _onGetStarted(state),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Full-screen page widget used inside AnimatedSwitcher ──────────────────────

class _OnboardingPageContent extends StatelessWidget {
  final dynamic page; // OnboardingModel
  const _OnboardingPageContent({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return OnboardingCard(page: page);
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _GetStartedButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _GetStartedButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.white,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
