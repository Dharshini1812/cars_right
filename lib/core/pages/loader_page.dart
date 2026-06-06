import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class LoaderScreen extends StatefulWidget {
  final String nextRoute; // ← UNCOMMENT THIS
  final int durationMs;

  const LoaderScreen({
    super.key,
    required this.nextRoute, // ← REQUIRED
    this.durationMs = 2500,
  });

  @override
  State<LoaderScreen> createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();

    Future.delayed(Duration(milliseconds: widget.durationMs), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, widget.nextRoute); // ← USE IT
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LoaderAnimation(),
              const SizedBox(height: 32),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Cars',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: AppColors.accent,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextSpan(
                      text: 'Right',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'INSPECT · VALUE · SELL',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textGrey,
                  letterSpacing: 1.8,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoaderAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _AnimatedShield();
  }
}

class _AnimatedShield extends StatefulWidget {
  @override
  State<_AnimatedShield> createState() => _AnimatedShieldState();
}

class _AnimatedShieldState extends State<_AnimatedShield>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _scaleAnim = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
    _glowAnim = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFEEEBFF),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withOpacity(_glowAnim.value),
                blurRadius: 40,
                spreadRadius: 4,
              ),
            ],
          ),
          child: const Icon(
            Icons.verified_user_rounded,
            size: 60,
            color: AppColors.accent,
          ),
        ),
      ),
    );
  }
}
