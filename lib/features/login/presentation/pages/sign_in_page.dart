import 'package:cars_right/features/offline_camera/presentation/pages/offline_bottom_sheet.dart';
import 'package:cars_right/features/login/presentation/provider.dart';
import 'package:cars_right/features/login/presentation/widgets/offline_camera_tile.dart';
import 'package:cars_right/features/login/presentation/widgets/shield_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';

class PhoneLoginScreen extends ConsumerStatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  ConsumerState<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends ConsumerState<PhoneLoginScreen> {
  void _showOfflineCameraSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const OfflineCameraBottomSheet(),
    );
  }

  final _phoneCtrl = TextEditingController();
  final _phoneFocus = FocusNode();
  bool _isPhoneValid = false;

  @override
  void initState() {
    super.initState();

    _phoneCtrl.addListener(() {
      setState(() {
        _isPhoneValid = _phoneCtrl.text.length == 10;
      });
    });
  }

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    final phone = _phoneCtrl.text.trim();
    if (phone.length < 10) return;

    _phoneFocus.unfocus();
    await ref.read(authProvider.notifier).sendOtp(phone);

    // ← ADD THIS: Navigate to loader which then goes to OTP
    Navigator.pushReplacementNamed(context, '/auth-loader');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);

    // ── Navigate to loader → OTP after OTP is sent ──────────────────────
    ref.listen(authProvider, (prev, next) {
      if (prev?.status != AuthStatus.otpSent &&
          next.status == AuthStatus.otpSent) {
        Navigator.pushNamed(context, '/auth-loader');
      }
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),

                        // ── Shield icon ─────────────────────────────────────────────
                        const Center(child: ShieldIcon()),

                        const SizedBox(height: 20),

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

                        const SizedBox(height: 8),

                        // ── Subtitle ────────────────────────────────────────────────
                        const Center(
                          child: Text(
                            'Log in with OTP to manage inspections, leads,\nreports, and valuation tasks.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13.5,
                              color: AppColors.textGrey,
                              height: 1.55,
                            ),
                          ),
                        ),

                        const SizedBox(height: 36),

                        // ── Phone number label ──────────────────────────────────────
                        const Text(
                          'Phone Number',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // ── Phone input ─────────────────────────────────────────────
                        _PhoneField(
                          controller: _phoneCtrl,
                          focusNode: _phoneFocus,
                        ),

                        const SizedBox(height: 24),

                        // ── Send OTP button ─────────────────────────────────────────
                        _PrimaryButton(
                          label: 'Send OTP',
                          isLoading: state.isLoading,
                          isEnabled: _isPhoneValid,
                          onTap: _sendOtp,
                        ),

                        const SizedBox(height: 24),

                        // ── Offline camera tile ─────────────────────────────────────
                        OfflineCameraTile(
                            onTap: () => _showOfflineCameraSheet(context)),

                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const _PhoneField({
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Country code
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
              ),
            ),
            child: const Text(
              '+91',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xff064f86),
              ),
            ),
          ),

          // Number input
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark,
              ),
              decoration: const InputDecoration(
                hintText: 'Enter your phone number',
                hintStyle: TextStyle(
                  color: Color(0xFFB0B5C0),
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _PrimaryButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onTap;
  final bool isEnabled;

  const _PrimaryButton({
    required this.label,
    required this.isLoading,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (!isLoading && isEnabled) ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: isEnabled ? AppColors.loginColor : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (isEnabled)
              BoxShadow(
                color: AppColors.loginColor.withOpacity(0.35),
                blurRadius: 25,
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
              : Text(
                  label,
                  style: const TextStyle(
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
