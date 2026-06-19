import 'package:cars_right/features/login/data/model/send_otp_model.dart';
import 'package:cars_right/features/login/domain/usecase/send_otp.dart';
import 'package:cars_right/features/login/presentation/logic/send_otp/send_otp_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendOtpNotifier extends StateNotifier<SendOtpState> {
  // final Ref ref;
  final SendOtpUsecase _usecase;

  SendOtpNotifier({
    required SendOtpUsecase usecase,
    SendOtpState? initialState,
  })  : _usecase = usecase,
        super(initialState ?? const SendOtpState.initial());

  Future<void> sendOtp(SendOtpModel params) async {
    state = const SendOtpState.loading();
    final result = await _usecase(params);
    result.fold(
      (l) => state = SendOtpState.error(l.msg ?? 'An error occurred'),
      (r) => state = SendOtpState.data(r.message ?? 'OTP Sent Successfully'),
    );
  }
}
