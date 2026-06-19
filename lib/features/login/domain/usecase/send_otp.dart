import 'package:cars_right/core/error/faliure.dart';
import 'package:cars_right/core/usecase/usecase.dart';
import 'package:cars_right/features/login/data/model/send_otp_model.dart';
import 'package:cars_right/features/login/domain/repository/login_repository.dart';
import 'package:dartz/dartz.dart';

class SendOtpUsecase implements UseCase<SendOtpModel> {
  final LoginRepository _repository;
  SendOtpUsecase(this._repository);

  @override
  Future<Either<Failure, SendOtpModel>> call(SendOtpModel params) async {
    final result = await _repository.sendOtp(params);
    return result;
  }
}
