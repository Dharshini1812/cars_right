import 'dart:async';
import 'package:cars_right/features/offline_camera/presentation/pages/offline_bottom_sheet.dart';
import 'package:cars_right/features/login/presentation/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import '../widgets/offline_camera_tile.dart';
import '../widgets/shield_icon.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  void _showOfflineCameraSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const OfflineCameraBottomSheet(),
    );
  }

  // 4 separate controllers + focus nodes for the OTP boxes
  final List<TextEditingController> _ctrlList =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusList = List.generate(4, (_) => FocusNode());

  // Resend cooldown timer
  int _resendSeconds = 30;
  Timer? _resendTimer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
    // Auto-focus first box
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _focusList[0].requestFocus(),
    );
  }

  @override
  void dispose() {
    for (final c in _ctrlList) {
      c.dispose();
    }
    for (final f in _focusList) {
      f.dispose();
    }
    _resendTimer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _resendSeconds = 30;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_resendSeconds > 0) {
        setState(() => _resendSeconds--);
      } else {
        _resendTimer?.cancel();
      }
    });
  }

  String get _fullOtp => _ctrlList.map((c) => c.text).join();

  void _onOtpDigit(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      _focusList[index + 1].requestFocus();
    }
    ref.read(authProvider.notifier).updateOtp(_fullOtp);
  }

  void _onBackspace(int index) {
    if (_ctrlList[index].text.isEmpty && index > 0) {
      _focusList[index - 1].requestFocus();
      _ctrlList[index - 1].clear();
    }
    ref.read(authProvider.notifier).updateOtp(_fullOtp);
  }

  Future<void> _verify() async {
    if (_fullOtp.length < 4) return;
    for (final f in _focusList) {
      f.unfocus();
    }
    await ref.read(authProvider.notifier).verifyOtp();
  }

  Future<void> _resend() async {
    if (_resendSeconds > 0) return;
    for (final c in _ctrlList) {
      c.clear();
    }
    ref.read(authProvider.notifier).updateOtp('');
    await ref.read(authProvider.notifier).resendOtp();
    _startResendTimer();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);

    // Navigate after successful verification
    ref.listen(authProvider, (prev, next) {
      if (prev?.status != AuthStatus.success &&
          next.status == AuthStatus.success) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // ── Back ────────────────────────────────────────────────────
              GestureDetector(
                onTap: () {
                  ref.read(authProvider.notifier).editPhone();
                  Navigator.pop(context);
                },
                child: const Icon(Icons.chevron_left_rounded,
                    size: 32, color: AppColors.textDark),
              ),

              const SizedBox(height: 36),

              // ── Shield ──────────────────────────────────────────────────
              const Center(child: ShieldIcon()),

              const SizedBox(height: 32),

              // ── Title ───────────────────────────────────────────────────
              const Center(
                child: Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Center(
                child: Text(
                  'Log in with OTP to manage inspections, leads,\nreports, and valuation tasks.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textGrey,
                    height: 1.55,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ── "OTP sent to" banner ────────────────────────────────────
              _OtpSentBanner(
                phone: '+91 ${state.phone}',
                onEdit: () {
                  ref.read(authProvider.notifier).editPhone();
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 24),

              // ── OTP label ───────────────────────────────────────────────
              const Text(
                'Enter 4-digit OTP',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),

              const SizedBox(height: 14),

              // ── 4 OTP boxes ─────────────────────────────────────────────
              Row(
                children: List.generate(4, (i) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: i < 3 ? 12 : 0),
                      child: _OtpBox(
                        controller: _ctrlList[i],
                        focusNode: _focusList[i],
                        onChanged: (v) => _onOtpDigit(i, v),
                        onBackspace: () => _onBackspace(i),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 24),

              // ── Verify button ───────────────────────────────────────────
              _VerifyButton(
                isLoading: state.isLoading,
                onTap: _verify,
              ),

              const SizedBox(height: 16),

              // ── Resend ──────────────────────────────────────────────────
              Center(
                child: GestureDetector(
                  onTap: _resend,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Didn't receive? ",
                          style: TextStyle(
                              color: AppColors.textGrey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: _resendSeconds > 0
                              ? 'RESEND OTP in ${_resendSeconds}s'
                              : 'RESEND OTP',
                          style: TextStyle(
                            color: _resendSeconds > 0
                                ? AppColors.textGrey
                                : const Color(0xffff795f),
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Offline camera tile ─────────────────────────────────────
              OfflineCameraTile(onTap: () => _showOfflineCameraSheet(context)),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _OtpSentBanner extends StatelessWidget {
  final String phone;
  final VoidCallback onEdit;

  const _OtpSentBanner({required this.phone, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEBFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded,
              color: Color(0xff064f86), size: 20),
          const SizedBox(width: 8),
          Text(
            'OTP sent to  ',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textGrey,
            ),
          ),
          Text(
            phone,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xff064f86),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onEdit,
            child: const Text(
              'Edit',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onBackspace;

  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: focusNode,
      builder: (_, child) {
        final isFocused = focusNode.hasFocus;

        return Container(
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isFocused ? AppColors.loginColor : const Color(0xFFE5E7EB),
              width: isFocused ? 2 : 1.5,
            ),
          ),
          child: child,
        );
      },
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: onChanged,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: AppColors.textDark,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
// ─────────────────────────────────────────────────────────────────────────────

class _VerifyButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;

  const _VerifyButton({required this.isLoading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.loginColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.loginColor.withOpacity(0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : const Text(
                  'Verify & Open Portal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
        ),
      ),
    );
  }
}
