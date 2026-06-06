import 'package:cars_right/core/pages/loader_page.dart';
import 'package:cars_right/features/dashboard/home/presentation/pages/bottom_nav/bottom_nav_page.dart';
import 'package:cars_right/features/login/presentation/pages/otp_page.dart';
import 'package:cars_right/features/login/presentation/pages/sign_in_page.dart';
import 'package:cars_right/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:cars_right/features/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: CarsRightApp(),
    ),
  );
}

class CarsRightApp extends StatelessWidget {
  const CarsRightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CarsRight',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        // ── Splash (auto-navigates to onboarding) ────────────────────────
        '/': (_) => const SplashScreen(),

        // ── Onboarding (user clicks "Get Started") ────────────────────────
        '/onboarding': (_) => const OnboardingScreen(),

        // ── Loader between Onboarding → Phone Login ──────────────────────
        '/onboarding-loader': (_) => const LoaderScreen(
              nextRoute: '/login',
              durationMs: 2500,
            ),

        // ── Phone Login (user enters phone, clicks "Send OTP") ───────────
        '/login': (_) => const PhoneLoginScreen(),

        // ── Loader between Phone Login → OTP ──────────────────────────────
        '/auth-loader': (_) => const LoaderScreen(
              nextRoute: '/otp',
              durationMs: 2000,
            ),

        // ── OTP Verification (user enters OTP, clicks "Verify") ──────────
        '/otp': (_) => const OtpScreen(),

        // ── Home ───────────────────────────────────────────────────────────
        '/home': (_) => const BottomNavPage(),
      },
    );
  }
}
