import 'package:cars_right/core/error/faliure.dart';
import 'package:cars_right/core/usecase/usecase.dart';
import 'package:cars_right/features/login/data/model/verify_otp_model.dart';
import 'package:cars_right/features/login/domain/repository/login_repository.dart';
import 'package:dartz/dartz.dart';

class VerifyOtpUsecase implements UseCase<VerifyOtpModel> {
  final LoginRepository _repository;

  VerifyOtpUsecase(this._repository);

  @override
  Future<Either<Failure, VerifyOtpModel>> call(VerifyOtpModel params) {
    final result = _repository.verifyOtp(params);
    return result;
  }
}
