import 'package:cars_right/features/login/data/datasource/remote_datasource.dart';
import 'package:cars_right/features/login/data/repository/login_repoistory_impl.dart';
import 'package:cars_right/features/login/domain/repository/login_repository.dart';
import 'package:cars_right/features/login/domain/usecase/send_otp.dart';
import 'package:cars_right/features/login/domain/usecase/verify_otp.dart';
import 'package:cars_right/features/login/presentation/logic/send_otp/send_otp_notifier.dart';
import 'package:cars_right/features/login/presentation/logic/send_otp/send_otp_state.dart';
import 'package:cars_right/features/login/presentation/logic/verify_otp/verify_otp_notifier.dart';
import 'package:cars_right/features/login/presentation/logic/verify_otp/verify_otp_state.dart';
import 'package:cars_right/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── State ─────────────────────────────────────────────────────────────────────

enum AuthStatus { idle, loading, otpSent, verifying, success, error }

class AuthState {
  final AuthStatus status;
  final String phone; // e.g. "89757 89646"
  final String otp; // digits typed so far
  final String? error;

  const AuthState({
    this.status = AuthStatus.idle,
    this.phone = '',
    this.otp = '',
    this.error,
  });

  bool get isLoading =>
      status == AuthStatus.loading || status == AuthStatus.verifying;

  AuthState copyWith({
    AuthStatus? status,
    String? phone,
    String? otp,
    String? error,
  }) =>
      AuthState(
        status: status ?? this.status,
        phone: phone ?? this.phone,
        otp: otp ?? this.otp,
        error: error,
      );
}

// ── Notifier ──────────────────────────────────────────────────────────────────

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  // Called when user taps "Send OTP"
  Future<void> sendOtp(String phone) async {
    state = state.copyWith(status: AuthStatus.loading, phone: phone);

    // TODO: replace with your real API call
    await Future.delayed(const Duration(seconds: 2));

    state = state.copyWith(status: AuthStatus.otpSent);
  }

  // Called when user updates OTP digits
  void updateOtp(String otp) {
    state = state.copyWith(otp: otp);
  }

  // Called when user taps "Verify & Open Portal"
  Future<void> verifyOtp() async {
    state = state.copyWith(status: AuthStatus.verifying);

    // TODO: replace with your real OTP verification call
    await Future.delayed(const Duration(seconds: 2));

    state = state.copyWith(status: AuthStatus.success);
  }

  // Reset back to phone entry (Edit button)
  void editPhone() {
    state = state.copyWith(
      status: AuthStatus.idle,
      otp: '',
      error: null,
    );
  }

  // Resend OTP
  Future<void> resendOtp() async {
    state = state.copyWith(status: AuthStatus.loading);
    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(status: AuthStatus.otpSent, otp: '');
  }
}

// ── Provider ──────────────────────────────────────────────────────────────────

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (_) => AuthNotifier(),
);

//--------Apiservice---------
final apiService = Provider<ApiService>((ref) => ApiServiceImpl(ref));

//sendOtp
final _loginRemoteDataSource =
    Provider<LoginRemoteDataSource>((ref) => LoginRemoteDataSourceImpl(ref));
final _repository = Provider<LoginRepository>(
    (ref) => LoginRepositoryImpl(ref.read(_loginRemoteDataSource)));

//Usecase-sendOtp
final _sendOtp =
    Provider<SendOtpUsecase>((ref) => SendOtpUsecase(ref.read(_repository)));
//Usecase-verifyOtp
final _verifyOtp = Provider<VerifyOtpUsecase>(
    (ref) => VerifyOtpUsecase(ref.read(_repository)));

//provider-sendotp
final sendOtpProvider = StateNotifierProvider<SendOtpNotifier, SendOtpState>(
    (ref) => SendOtpNotifier(usecase: ref.read(_sendOtp)));

//provider-verifyOtp
final verifyOtpProvider =
    StateNotifierProvider<VerifyOtpNotifier, VerifyOtpState>(
        (ref) => VerifyOtpNotifier(usecase: ref.read(_verifyOtp)));
