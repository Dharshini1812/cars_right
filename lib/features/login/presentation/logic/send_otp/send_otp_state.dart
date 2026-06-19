import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_otp_state.freezed.dart';

@freezed
class SendOtpState with _$SendOtpState {
  const factory SendOtpState.initial() = _SendOtpStateInitial;
  const factory SendOtpState.loading() = _SendOtpStateLoading;
  const factory SendOtpState.data(String msg) = _SendOtpStateData;
  const factory SendOtpState.error(String msg) = _SendOtpStateError;
}
