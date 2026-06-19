import 'package:cars_right/core/error/faliure.dart';
import 'package:cars_right/features/login/data/model/send_otp_model.dart';
import 'package:cars_right/features/login/data/model/verify_otp_model.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure, SendOtpModel>> sendOtp(SendOtpModel model);
  Future<Either<Failure, VerifyOtpModel>> verifyOtp(VerifyOtpModel model);
}
