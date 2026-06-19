import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_otp_state.freezed.dart';

@freezed
class VerifyOtpState with _$VerifyOtpState {
  const factory VerifyOtpState.initial() = _VerifyOtpStateInitial;
  const factory VerifyOtpState.loading() = _VerifyOtpStateLoading;
  const factory VerifyOtpState.data() = _VerifyOtpStateData;
  const factory VerifyOtpState.error(String msg) = _VerifyOtpStateError;
}
