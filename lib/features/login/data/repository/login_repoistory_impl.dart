import 'package:cars_right/core/error/faliure.dart';
import 'package:cars_right/features/login/data/datasource/remote_datasource.dart';
import 'package:cars_right/features/login/data/model/send_otp_model.dart';
import 'package:cars_right/features/login/data/model/verify_otp_model.dart';
import 'package:cars_right/features/login/domain/repository/login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDataSource _loginRemoteDataSource;

  LoginRepositoryImpl(this._loginRemoteDataSource);

  @override
  Future<Either<Failure, SendOtpModel>> sendOtp(SendOtpModel model) async {
    try {
      final data = await _loginRemoteDataSource.sendOtp(model);
      return Right(data);
    } catch (e) {
      return Left(CustomFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, VerifyOtpModel>> verifyOtp(
      VerifyOtpModel model) async {
    try {
      final data = await _loginRemoteDataSource.verifyOtp(model);
      return Right(data);
    } catch (e) {
      return Left(CustomFailure(msg: e.toString()));
    }
  }
}
